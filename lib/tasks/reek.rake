require 'reek/rake/task'

desc 'Find smelly code'
task :reek do
  BK::Gem::Minitest::Configuration.reek_task = Reek::Rake::Task.new do |t|
    t.config_files  = ["#{BK::Gem::Minitest::Configuration.root}/config/code.reek", 'config/**/*.reek']
    t.source_files  = 'lib/ld/**/*.rb'
    t.fail_on_error = false
  end
end
