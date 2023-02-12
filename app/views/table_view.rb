# frozen_string_literal: true

require_relative '../../lib/beholder/observer'

class TableView
  include Beholder::Observer
  def initialize(table)
    @table = table
    subscribe_to(@table)
  end

  def update(*_args)
    @table.processes.each do |process|
      puts "process id: #{process.pid} process name: #{process.pname}"
    end
  end
end
