# frozen_string_literal: true

require_relative '../app/models/proc_list/process'
require_relative '../app/models/proc_list/table'
require_relative '../app/views/table_view'
require_relative '../lib/beholder/observer'
require_relative '../lib/beholder/producer'
require 'io/console'

table = ProcList::Table.new

table_view = TableView.new(table)

Thread.new do
  thread = Application::Input.listen do |type, event|
    if type == :key
      puts "Key pressed: #{event.inspect}"
    elsif type == :mouse
      puts "Mouse event: #{event.inspect}"
    end
  end

  thread.daemon = true

  loop do
    table.refresh!
    sleep 1
    `clear`
  end
end.join

