# frozen_string_literal: true

require_relative '../app/models/proc_list/process'
require_relative '../app/models/proc_list/table'
require_relative '../app/views/table_view'
require_relative '../lib/beholder/observer'
require_relative '../lib/beholder/producer'
require 'io/console'

include Application::Input

def run
  table = ProcList::Table.new
  table_view = TableView.new(table)

  raw_mode

  stop_requested = false
  trap('SIGINT') { stop_requested = true }

  begin
    loop do
      if stop_requested
        puts "\r\nExiting program\r\n"
        break
        exit
      end

      if input = read_input
        if input == 'q'
          print "\r\nExiting program\r\n"
          break
        end    
      end

      table.refresh!
      `clear`
      sleep 1
    end

  ensure
    exit
    skip_raw_mode
  end
end

run