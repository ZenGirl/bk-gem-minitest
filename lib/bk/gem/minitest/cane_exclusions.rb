require 'bk/gem/minitest'
config = BK::Gem::Minitest::Configuration
BK::Gem::Minitest::ColoredLogger.new.green "Testing: Cane: Configuring exclusions in #{__FILE__}" if ENV['VERBOSE']
config.load_rake_files
# config.cane_task.style_exclude << 'spec/**/*_spec.rb'
# config.cane_task.abc_exclude << 'spec/**/*_spec.rb'
# LD::Gem::Testing::Configuration.test_task is available

# We're specifically ignoring the helper
BK::Gem::Minitest::Configuration.cane_task.abc_exclude << 'lib/bk/gem/minitest/spec_helper.rb'
