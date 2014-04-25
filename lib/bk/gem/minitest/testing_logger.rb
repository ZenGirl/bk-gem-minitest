module BK
  module Gem
    module Minitest

      ##
      # Just a colored logger
      class ColoredLogger

        def red(msg)
          colorize(msg, 31)
        end

        def green(msg)
          colorize(msg, 32)
        end

        def yellow(msg)
          colorize(msg, 33)
        end

        def blue(msg)
          colorize(msg, 34)
        end

        private

        def colorize(msg, color_code)
          output("\e[#{color_code}m#{msg}\e[0m")
        end

        def output(msg)
          puts(msg) if ENV['VERBOSE']
        end
      end

    end
  end
end
