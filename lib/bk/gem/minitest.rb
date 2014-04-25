require 'bk/gem/minitest/version'

require 'bk/gem/minitest/spec_helper'
require 'bk/gem/minitest/testing_logger'

require 'active_support/testing/constant_lookup'

require 'minitest'
# require 'minitest/autorun'
# require 'minitest/unit'
require 'minitest/spec'
# require 'minitest/mock'
# require 'minitest/reporters'
require 'minitest/stub_any_instance'

##
# Create the +described-class+ method for the tests
class ::MiniTest::Spec
  include ActiveSupport::Testing::ConstantLookup

  class << self
    alias :context :describe

    def described_class(class_name)
      determine_constant_from_test_name(class_name) do |constant|
        Class === constant
      end
    end
  end

  def initialize(*args)
    Thread.current[:current_spec] = self
    super
  end

  # :reek:UtilityFunction
  def current_spec
    Thread.current[:current_spec] || Class.new
  end

  def described_class
    self.class.described_class(current_spec.class.name)
  end

end

module BK
  module Gem
    module Minitest

      ##
      # Testing for free.
      #
      # Used by external gems to automatically add a standard set of testing routines
      # and gems to your project.
      # No clutter in your project and free from cut-n-paste issues.
      class Configuration

        def self.root
          File.expand_path(File.join(File.dirname(__FILE__), '../../..'))
        end

        def self.rake_files
          Dir.glob("#{root}/lib/tasks/*.rake")
        end

        # :reek:ControlParameter
        def self.load_rake_files(options={})
          BK::Gem::Minitest::ColoredLogger.new.green 'Testing: Loading Rake files...'
          rake_files.each do |rake_file|
            BK::Gem::Minitest::ColoredLogger.new.yellow "Testing: Loading #{rake_file}" if options[:verbose]
            load rake_file
          end
        end

        def self.include_testing_gemfile
          gemfile = "#{root}/config/Gemfile"
          eval(IO.read(gemfile), binding)
        end

        def self.cane_task
          @cane_task
        end

        def self.cane_task=(task)
          @cane_task = task
        end

        def self.test_task
          @test_task
        end

        def self.test_task=(task)
          @test_task = task
        end

        def self.reek_task
          @reek_task
        end

        def self.reek_task=(task)
          @reek_task = task
        end

      end

    end
  end
end
