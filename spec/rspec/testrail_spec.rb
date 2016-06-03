require 'spec_helper'

describe RSpec::Testrail do
  let(:site_runs) do
    [{ id: 321,
       name: "Test run for #{RSpec::Testrail.options[:git_branch]}",
       suite_id: RSpec::Testrail.options[:suite_id] }]
  end

  it 'has a version number' do
    expect(RSpec::Testrail::VERSION).not_to be nil
  end

  it 'processing example', testrail_id: 123 do |example|
    stub_request(:get, "#{RSpec::Testrail.options[:url]}/index.php?/api/v2/get_runs/\
#{RSpec::Testrail.options[:project_id]}")
      .with(basic_auth: [RSpec::Testrail.options[:user], RSpec::Testrail.options[:password]])
      .to_return(status: 200, body: site_runs.to_json)

    stub_request(:post, "#{RSpec::Testrail.options[:url]}/index.php?/api/v2/update_run/\
#{site_runs[0][:id]}")
      .with(basic_auth: [RSpec::Testrail.options[:user], RSpec::Testrail.options[:password]],
            body: { description: "Revision: #{RSpec::Testrail.options[:git_revision]}" }.to_json)
      .to_return(status: 200, body: site_runs[0].to_json)

    stub_request(:post, "#{RSpec::Testrail.options[:url]}/index.php?/api/v2/add_result_for_case/\
#{site_runs[0][:id]}/#{example.metadata[:testrail_id]}")
      .with(basic_auth: [RSpec::Testrail.options[:user], RSpec::Testrail.options[:password]],
            body: { status_id: 1, comment: '' }.to_json)
      .to_return(status: 200, body: '')

    expect(RSpec::Testrail.process(example)).to eq({})
  end
end
