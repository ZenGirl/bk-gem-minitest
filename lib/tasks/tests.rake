namespace :tests do

  desc 'Configure Testing Environment'
  task :configure do
    # Nothing to do
  end

  desc 'Run quality, all specs'
  task :all => [:configure, :test, :reek, :cane_quality]

end
