begin
  require 'cane/rake_task'
  require 'awesome_print'

  desc 'Run cane to check quality metrics'
  BK::Gem::Minitest::Configuration.cane_task = Cane::RakeTask.new(:quality) do |cane|
    cane.parallel    = true
    cane.no_doc      = true

    # cane.color       = true
    # cane.add_threshold 'coverage/covered_percent', :>=, 99
    # cane.no_style = true

    cane.abc_glob    = '{app,lib}/**/*.rb'
    cane.abc_max     = 10
    cane.abc_exclude = Dir.glob('test/**/*.rb')

    cane.style_glob    = '{app,lib}/**/*.rb'
    cane.style_measure = 120
    cane.style_exclude = Dir.glob('test/**/*.rb')

    if ENV['VERBOSE']
      puts 'Cane: ABC checks will be run against:'
      Dir.glob(cane.abc_glob).each do |file|
        puts "  #{file}"
      end
      puts 'Cane: Style checks will be run against:'
      Dir.glob(cane.style_glob).each do |file|
        puts "  #{file}"
      end
    end
  end

  task :cane_quality do
    puts "Cane: Exclusions: [#{Dir.pwd}/test/support/cane_exclusions.rb]" if ENV['VERBOSE']
    begin
      # noinspection RubyResolve
      require "#{Dir.pwd}/test/support/cane_exclusions"
    rescue LoadError
    end
    # ap BK::Gem::Minitest::Configuration.cane_task, raw: true if ENV['VERBOSE']
    Rake.application.invoke_task('quality')
  end

  task :default => :quality
rescue LoadError
  warn 'cane not available, quality task not provided.'
end
