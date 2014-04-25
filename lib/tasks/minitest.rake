require 'rake/testtask'
BK::Gem::Minitest::Configuration.test_task = Rake::TestTask.new do |t|
  t.libs.push 'test'
  t.pattern = 'test/**/*_spec.rb'
end
