# frozen_string_literal: true

module Application
  class Window
    def self.window
      return @window if @window

      Curses.init_screen
      Curses.start_color
      Curses.noecho # turn off character display
      Curses.use_default_colors
      @window = Curses.stdscr
    end

    def self.refresh!
      window.refresh
    end
  end
end
