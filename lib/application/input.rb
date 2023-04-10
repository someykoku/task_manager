# frozen_string_literal: true

require 'io/console'

module Application
  module Input
    def self.init
      Curses.stdscr.keypad(true) # enable special key support
      Curses.stdscr.nodelay = true # asynchronous mode
      Curses.stdscr.timeout = 0
    end

    def self.read_input
      Application::Window.window.getch
    end
  end
end
