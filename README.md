# BK::Gem::Minitest

Provides automatic minitest actions to your project

## Installation

Add this line to your application's Gemfile:

    gem 'bk-gem-minitest', git: 'git@github.com:ZenGirl/bk-gem-minitest.git', require: 'bk/gem/minitest'

After the `gemspec` line.

And then execute:

    $ bundle install

## Usage

Simple including the gem in your project will provide minitest rake tasks.
For an example, there is another project called `bk-gem-app_config`.
When cloned and bundled, you'll see it has no spec helpers or any other test scaffolding.
In fact the only parts are the `test/**/*_spec.rb` files themselves.

So in that project, the `Rakefile` looks like this:

    #!/usr/bin/env rake

    ENV['RACK_ENV'] ||= 'test'
    require 'bk/gem/minitest/load_test_rake_files' if ENV['RACK_ENV'].downcase == 'test'

    desc 'Run Specs'
    task :default => :test

And if you run `bundle exec rake -T` you see this:

    rake default          # Run Specs
    rake quality          # Run cane to check quality metrics
    rake reek             # Find smelly code
    rake test             # Run tests
    rake tests:all        # Run quality, all specs
    rake tests:configure  # Configure Testing Environment

So how do you use this?
First you need to add a small block to the top of your `test/**/*_spec.rb` files.
Here's an example from the `bk-gem-app_config` spec:

    require 'bk/gem/minitest'
    BK::Gem::Minitest::SpecHelper.base do |config|
      require 'bk/gem/app_config'
    end

And that's it. You can use `describe`, `described_class`, `stub_any_instance` and what not to your hearts content.

So what happens when you run tests?

    Run options: --seed 40632

    # Running:

    ..

    Finished in 0.001980s, 1010.1010 runs/s, 2525.2525 assertions/s.

    2 runs, 5 assertions, 0 failures, 0 errors, 0 skips
    Coverage report generated for Minitest to /Users/kim/RubymineProjects/GitHub/Gems/bk-gem-app_config/test/coverage. 30 / 30 LOC (100.0%) covered.

So you now have coverage reports in `test/coverage` and your specs where minitest'd, simplecov'd, cane'd and reek'd.

If you have cane or reek violations, they will show up.

The code will set an exit code for tests and cane of 1 or 0.
This means you can add it into your continuous deployment system.

A VERBOSE run shows a lot of background stuff which may be of use in tracking down problems:

    VERBOSE=true bundle exec rake tests:all
    Testing: Loading Rake files...
    Testing: Loading /Users/kim/.rvm/gems/ruby-2.0.0-p451@bk-gem-app_config/bundler/gems/bk-gem-minitest-2205daa6df12/lib/tasks/cane.rake
    Cane: ABC checks will be run against:
      lib/bk/gem/app_config/version.rb
      lib/bk/gem/app_config.rb
    Cane: Style checks will be run against:
      lib/bk/gem/app_config/version.rb
      lib/bk/gem/app_config.rb
    Testing: Loading /Users/kim/.rvm/gems/ruby-2.0.0-p451@bk-gem-app_config/bundler/gems/bk-gem-minitest-2205daa6df12/lib/tasks/minitest.rake
    Testing: Loading /Users/kim/.rvm/gems/ruby-2.0.0-p451@bk-gem-app_config/bundler/gems/bk-gem-minitest-2205daa6df12/lib/tasks/reek.rake
    Testing: Loading /Users/kim/.rvm/gems/ruby-2.0.0-p451@bk-gem-app_config/bundler/gems/bk-gem-minitest-2205daa6df12/lib/tasks/tests.rake
    Testing: Configuring SimpleCov
    Testing: ENV['PROJECT_ROOT'] set to /Users/kim/RubymineProjects/GitHub/Gems/bk-gem-app_config
    Testing: Loading internal cane exclusions
    Testing: Cane: Configuring exclusions in /Users/kim/.rvm/gems/ruby-2.0.0-p451@bk-gem-app_config/bundler/gems/bk-gem-minitest-2205daa6df12/lib/bk/gem/minitest/cane_exclusions.rb
    Testing: Loading Rake files...
    Cane: ABC checks will be run against:
      lib/bk/gem/app_config/version.rb
      lib/bk/gem/app_config.rb
    Cane: Style checks will be run against:
      lib/bk/gem/app_config/version.rb
      lib/bk/gem/app_config.rb
    Testing: Yielding to your project block if present
    Testing: Back from your project block if present
    Testing: Cane: Current Exclusions:
    Testing: Cane: Style: ["test/lib/bk/gem/app_config/app_config_spec.rb"]
    Testing: Cane: ABC:   ["test/lib/bk/gem/app_config/app_config_spec.rb", "lib/bk/gem/minitest/spec_helper.rb"]
    Testing: Loading any of your project spec/support files
    Run options: --seed 52258

    # Running:

    ..

    Finished in 0.002092s, 956.0229 runs/s, 2390.0574 assertions/s.

    2 runs, 5 assertions, 0 failures, 0 errors, 0 skips
    Coverage report generated for Minitest to /Users/kim/RubymineProjects/GitHub/Gems/bk-gem-app_config/test/coverage. 30 / 30 LOC (100.0%) covered.
    Cane: Exclusions: [/Users/kim/RubymineProjects/GitHub/Gems/bk-gem-app_config/test/support/cane_exclusions.rb]

There's a bit of duplication, but it shows what is going on.

If you want to exclude something from cane, create a `test/support/cane_exclusions.rb` file and put stuff in it like this:

    BK::Gem::Minitest::Configuration.cane_task.abc_exclude << 'Your::Gem::ClassName#method_1'
    BK::Gem::Minitest::Configuration.cane_task.abc_exclude << 'Your::Gem::ClassName#method_2'

You can add `style_exclude` as well.

## Contributing

Fork it ( https://github.com/ZenGirl/bk-gem-minitest/fork )

Play.

Found a bug? Tell me!
