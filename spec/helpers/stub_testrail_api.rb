# rubocop:disable Metrics/AbcSize
module Helpers
  def site_runs
    [{ id: 321,
       name: RSpec::Testrail.options[:run_name],
       suite_id: RSpec::Testrail.options[:suite_id] }]
  end

  def stub_get_runs
    stub_request(:get, "#{RSpec::Testrail.options[:url]}/index.php?/api/v2/get_runs/\
#{RSpec::Testrail.options[:project_id]}")
      .with(basic_auth: [RSpec::Testrail.options[:user], RSpec::Testrail.options[:password]])
      .to_return(status: 200, body: site_runs.to_json)
  end

  def stub_update_run
    stub_request(:post, "#{RSpec::Testrail.options[:url]}/index.php?/api/v2/update_run/\
#{site_runs[0][:id]}")
      .with(basic_auth: [RSpec::Testrail.options[:user], RSpec::Testrail.options[:password]],
            body: { description: RSpec::Testrail.options[:run_description] }.to_json)
      .to_return(status: 200, body: site_runs[0].to_json)
  end

  def stub_add_result_for_case(testrail_id)
    stub_request(:post, "#{RSpec::Testrail.options[:url]}/index.php?/api/v2/add_result_for_case/\
#{site_runs[0][:id]}/#{testrail_id}")
      .with(basic_auth: [RSpec::Testrail.options[:user], RSpec::Testrail.options[:password]],
            body: { status_id: 1, comment: '' }.to_json)
      .to_return(status: 200, body: '')
  end
end
