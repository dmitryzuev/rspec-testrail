require 'spec_helper'

describe RSpec::Testrail do
  include Helpers

  let(:options) do
    Hash(
      url: 'http://test.site',
      user: 'test@test.site',
      password: '12345678',
      project_id: 111,
      suite_id: 222,
      run_name: `git rev-parse --abbrev-ref HEAD`.strip,
      run_description: `git rev-parse HEAD`.strip
    )
  end

  before(:each) do
    RSpec::Testrail.reset
    RSpec::Testrail.init(options)
  end

  it 'has a version number' do
    expect(RSpec::Testrail::VERSION).not_to be nil
  end

  describe '.init' do
    it 'sets options' do
      expect(RSpec::Testrail.options).to eq(options)
    end
  end

  describe '.client' do
    it 'returns example of Client' do
      expect(RSpec::Testrail.client).to be_a_kind_of(RSpec::Testrail::Client)
    end
  end

  describe '.process', testrail_id: 123 do
    before(:each) do |example|
      stub_get_runs
      stub_update_run
      stub_add_result_for_case example.metadata[:testrail_id]

      RSpec::Testrail.process(example)
    end

    it 'gets all runs' do
      expect(WebMock).to have_requested(:get, "#{options[:url]}/index.php?/api/v2/get_runs/\
#{options[:project_id]}").with(basic_auth: [options[:user], options[:password]])
    end

    it 'gets run with specified name' do
      expect(WebMock).to have_requested(:post, "#{options[:url]}/index.php?/api/v2/update_run/\
#{site_runs[0][:id]}")
        .with(basic_auth: [options[:user], options[:password]],
              body: { description: options[:run_description] }.to_json)
    end

    it 'posts new run with specified name if none found'
  end
end
