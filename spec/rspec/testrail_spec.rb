require 'spec_helper'

describe RSpec::Testrail do
  include Helpers

  it 'has a version number' do
    expect(RSpec::Testrail::VERSION).not_to be nil
  end

  it 'processing example', testrail_id: 123 do |example|
    stub_get_runs
    stub_update_run
    stub_add_result_for_case example.metadata[:testrail_id]

    expect(RSpec::Testrail.process(example)).to eq({})
  end
end
