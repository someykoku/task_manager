# frozen_string_literal: true

require_relative '../../lib/beholder/observer'

class TableView
  include Beholder::Observer

  def initialize(table)
    @table = table
    subscribe_to(@table)
    @window = Application::Window.window
    @window.keypad(true) # enable special key support
    init_color_pairs
  end

  def init_color_pairs
    Curses.init_pair(1, Curses::COLOR_WHITE, Curses::COLOR_CYAN) # Define color pair 1 with a cyan background
    Curses.init_pair(2, Curses::COLOR_RED, Curses::COLOR_BLACK) # Define color pair 2 as red
    Curses.init_pair(3, Curses::COLOR_RED, Curses::COLOR_CYAN) # Define color pair 3 as red with cyan background
  end

  def update(*_args)
    height, width = win_size
    @window.clear
    draw_border(height, width)
    display_processes(height - 2)
    display_process_details
    Application::Window.refresh!
  end

  def draw_border(height, width)
    @window.box('|', '-')
    draw_corners(height, width)
  end

  def draw_corners(height, width)
    @window.setpos(0, 0)
    @window.addstr('+')
    @window.setpos(0, width - 1)
    @window.addstr('+')
    @window.setpos(height - 1, 0)
    @window.addstr('+')
    @window.setpos(height - 1, width - 1)
    @window.addstr('+')
  end

  def display_processes(height)
    @table.processes[indexes_to_show(height)].each_with_index do |process, index|
      display_process(process, index + 1) # Add 1 to account for the border
    end
  end

  def display_process(process, index)
    @window.setpos(index, 1) # Add 1 to account for the border
    highlight_process_if_selected(process)
    display_process_pid(process)
    display_process_name(process)
    fill_remaining_space_with_spaces(process) if process.selected
  end

  def highlight_process_if_selected(process)
    @window.attron(Curses.color_pair(1)) if process.selected # Use color pair 1 for the selected process
  end

  def display_process_pid(process)
    @window.attron(Curses.color_pair(process.selected ? 3 : 2)) # Use color pair 2 or 3 for the red text
    @window.addstr(process.pid.to_s)
    @window.attroff(Curses.color_pair(process.selected ? 3 : 2)) # Turn off color pair 2 or 3 for the red text
  end

  def display_process_name(process)
    @window.attron(Curses.color_pair(3)) if process.selected # Use color pair 3 for the red text
    @window.addstr(" #{process.pname}")
    @window.attroff(Curses.color_pair(3)) if process.selected # Turn off color pair 3 for the red text
  end

  def fill_remaining_space_with_spaces(_process)
    width = win_size[1]
    remaining_space = width - 1 - @window.curx
    @window.addstr(' ' * remaining_space) # Fill the rest of the line with spaces
    @window.attroff(Curses.color_pair(1)) # Turn off color pair 1 for the selected process
  end

  def display_process_details
    selected_process = @table.processes[@table.selected_process_index]
    details = "Details:\n"\
              "PID: #{selected_process.pid}\n"\
              "Name: #{selected_process.pname}\n"\
              "RAM: #{selected_process.ram}"
    # Adjust the starting position (y, x) based on your preferred location
    start_y = 1
    start_x = win_size[1] / 2
    details.split("\n").each_with_index do |line, index|
      @window.setpos(start_y + index, start_x)
      @window.addstr(line)
    end
  end

  def indexes_to_show(height)
    case @table.selected_process_index
    when 0..(height / 2)
      (0..(height - 1))
    when (@table.processes.length - height / 2)..Float::INFINITY
      (@table.processes.length - height..@table.processes.length)
    else
      (@table.selected_process_index - height / 2..@table.selected_process_index + height / 2)
    end
  end

  def win_size
    [Application::Window.window.maxy, Application::Window.window.maxx]
  end
end
