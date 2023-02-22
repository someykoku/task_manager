# frozen_string_literal: true

require_relative '../app/models/proc_list/process'
require_relative '../app/models/proc_list/table'
require_relative '../app/views/table_view'
require_relative '../lib/beholder/observer'
require_relative '../lib/beholder/producer'
require_relative '../lib/application/input'
require_relative '../lib/application/base_controller'
require_relative '../app/controllers/process_table_controller'


require 'io/console'

include Application::Input


def run
  table = ProcList::Table.new
  controller = ProcessTableController.new(table)
  table_view = TableView.new(table)

  # raw_mode

  begin
    loop do
      # controller.key_pressed(read_input)
      table.refresh!
      `clear`
      sleep 1
    end
  ensure
    # skip_raw_mode
    exit
  end
end

run