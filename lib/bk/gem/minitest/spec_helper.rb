module BK
  module Gem
      module Minitest

        ##
        # Common spec helper for all mini tests
        # :reek:TooManyStatements: { max_statements: 30 }
        # :reek:DuplicateMethodCall
        class SpecHelper

          def self.logger
            @logger
          end

          def self.base
            @logger = BK::Gem::Minitest::ColoredLogger.new

            # ---------------------------------------------------------------------------
            # Configure SimpleCov
            # ---------------------------------------------------------------------------
            @logger.green 'Testing: Configuring SimpleCov'
            require 'json'
            require 'simplecov'
            SimpleCov.start do
              add_filter '/test/'
              add_filter '/config/'
              command_name 'Minitest'
              coverage_dir 'test/coverage'
            end

            # ---------------------------------------------------------------------------
            # We have to set these here in case the start-up was from within RubyMine
            # ---------------------------------------------------------------------------
            ENV['RACK_ENV'] ||= 'test'
            require 'awesome_print'

            # ---------------------------------------------------------------------------
            # It may be used by tests
            # ---------------------------------------------------------------------------
            ENV['PROJECT_ROOT'] = Dir.pwd
            @logger.green "Testing: ENV['PROJECT_ROOT'] set to #{ENV['PROJECT_ROOT']}"

            # ---------------------------------------------------------------------------
            # Now we load up the test code.
            # We ALSO have to do this here regardless of the Rakefile because the
            # code may have been started by RubyMine
            # ---------------------------------------------------------------------------
            config = BK::Gem::Minitest::Configuration

            @logger.green 'Testing: Loading internal cane exclusions'
            require_relative 'cane_exclusions'

            @logger.red 'Testing: Yielding to your project block if present'
            yield config if block_given?

            @logger.red 'Testing: Back from your project block if present'
            if ENV['VERBOSE']
              @logger.yellow 'Testing: Cane: Current Exclusions:'
              @logger.yellow "Testing: Cane: Style: #{config.cane_task.style_exclude}"
              @logger.yellow "Testing: Cane: ABC:   #{config.cane_task.abc_exclude}"
            end

            require 'bk/gem/minitest'
            require 'minitest/autorun'

            # ---------------------------------------------------------------------------
            # Load any support files
            # ---------------------------------------------------------------------------
            @logger.green 'Testing: Loading any of your project spec/support files'
            Dir[File.join(ENV['PROJECT_ROOT'], 'spec/support/**/*.rb')].each do |support_file|
              @logger.yellow "Testing: Loading #{support_file}"
              # noinspection RubyResolve
              require support_file
            end

          end

        end

    end
  end
end
