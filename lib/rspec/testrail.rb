require 'rspec/testrail/version'
require 'rspec/testrail/client'

module RSpec
  module Testrail
    class << self
      attr_reader :options

      def init(hash = {})
        @options = {
          url: hash[:url],
          user: hash[:user],
          password: hash[:password],
          project_id: hash[:project_id],
          suite_id: hash[:suite_id],
          git_revision: `git rev-parse HEAD`.strip,
          git_branch: `git rev-parse --abbrev-ref HEAD`.strip
        }
        client
      end

      def client
        @client ||= Client.new(@options[:url], @options[:user], @options[:password])
      end

      def reset_client
        @client = nil
      end

      def process(example)
        if example.exception
          status = 5
          message = example.exception.message
        else
          status = 1
          message = ''
        end
        client.send_post("/add_result_for_case/#{testrun['id']}/#{example.metadata[:testrail_id]}",
                         status_id: status,
                         comment: message)
      end

      protected

      def testrun
        @testrun ||=
          if testruns.empty?
            client.send_post("/add_run/#{@options[:project_id]}",
                             suite_id: @options[:suite_id],
                             name: "Test run for #{git_branch}",
                             description: "Revision: #{git_revision}")
          else
            client.send_post("/update_run/#{testruns[0]['id']}",
                             description: "Revision: #{git_revision}")
          end
      end

      def testruns
        @testruns ||= client.send_get("/get_runs/#{@options[:project_id]}")
                            .select do |run|
                              run['suite_id'] == @options[:suite_id].to_i && \
                                run['name'].include?(@options[:git_branch])
                            end
      end
    end
  end
end
