# frozen_string_literal: true

require_relative '../app/models/proc_list/process'
require_relative '../app/models/proc_list/table'
require_relative '../app/views/table_view'
require_relative '../lib/beholder/observer'
require_relative '../lib/beholder/producer'

table = ProcList::Table.new

table_view = TableView.new(table)
loop do
  table.refresh!
  sleep 1
  `clear`
end
