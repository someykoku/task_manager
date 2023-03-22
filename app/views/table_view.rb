# frozen_string_literal: true

require_relative '../../lib/beholder/observer'

class TableView
  include Beholder::Observer

  def initialize(table)
    @table = table
    subscribe_to(@table)
  end

  def update(*_args)
    height = win_size[0]
    print "\e[2J"
    print "\e[H"
    @table.processes[indexes_to_show].each_with_index do |process, index|
      print "\e[44m" if process.selected
      print "process id: #{process.pid} process name: #{process.pname}"
      print "\e[0m" if process.selected
      print "\r\n" unless index == height - 1
    end
  end

  def indexes_to_show
    height = win_size[0]
    if @table.selected_process_index < height / 2
      (0..(height - 1))
    elsif @table.selected_process_index > @table.processes.length - height / 2
      (@table.processes.length - height..@table.processes.length)
    else
      (@table.selected_process_index - height / 2..@table.selected_process_index + height / 2)
    end
  end

  def win_size
    IO.console.winsize
  end
end
