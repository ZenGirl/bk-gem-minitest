require 'bk/gem/minitest'
require 'bk/gem/minitest/spec_helper'

BK::Gem::Minitest::SpecHelper.base do |config|

end

describe BK::Gem::Minitest::Configuration do

  it 'returns the rake files' do
    root       = described_class.root
    rake_files = described_class.rake_files
    rake_files.must_equal %W(
                          #{root}/lib/tasks/cane.rake
                          #{root}/lib/tasks/minitest.rake
                          #{root}/lib/tasks/reek.rake
                          #{root}/lib/tasks/tests.rake
                          )
  end

  it 'responds with it\'s physical directory' do
    described_class.root.must_equal File.expand_path(File.join(__dir__, '../../../../..'))
  end

end
