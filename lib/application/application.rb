module Application
  class BaseController
    class ProcessesTableController::BaseController
      def initialize(model)
        @model = model
      end
      def send_key
        key_x_action =
      end

      require 'curses'

      def select_process(processes)
        # Initialize curses
        Curses.noecho
        Curses.cbreak
        Curses.stdscr.keypad(true)

        # Get the dimensions of the terminal
        max_y, max_x = Curses.getmaxyx(Curses.stdscr)

        # Calculate the maximum number of processes that can be displayed on the screen
        max_processes = max_y - 3

        # Initialize the current process index
        current_process = 0

        loop do
          # Clear the screen
          Curses.clear

          # Print the list of processes
          processes.each_with_index do |process, i|
            if i == current_process
              Curses.attron(Curses.color_pair(1)) # highlight the selected process
            end
            Curses.setpos(i, 0)
            Curses.addstr(process.name)
            Curses.attroff(Curses.color_pair(1))
          end

          # Refresh the screen
          Curses.refresh

          # Get the next key press
          key = Curses.getch

          case key
          when Curses::Key::UP
            # Move the selection up
            current_process = [current_process - 1, 0].max
          when Curses::Key::DOWN
            # Move the selection down
            current_process = [current_process + 1, processes.length - 1].min
          when Curses::Key::ENTER, Curses::Key::RETURN
            # Return the selected process
            return processes[current_process]
          end

          # If there are more processes than can be displayed on the screen,
          # adjust the current process index so that the selected process is always visible
          if processes.length > max_processes
            if current_process < max_processes / 2
              current_process = 0
            elsif current_process >= processes.length - max_processes / 2
              current_process = processes.length - max_processes
            else
              current_process -= max_processes / 2
            end
          end
        end
      ensure
        # End curses
        Curses.echo
        Curses.nocbreak
        Curses.stdscr.keypad(false)
        Curses.close_screen
      end

    end
  end
end