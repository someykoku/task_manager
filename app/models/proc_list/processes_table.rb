# frozen_string_literal: true

require 'io/console'
require_relative '../../../lib/beholder/producer'

module ProcList
  class ProcessTable
    include Beholder::Producer

    attr_reader :processes

    def initialize
      @processes = []
    end

    def refresh!
      new_processes_list = Process.list

      new_pids = new_processes_list.map(&:pid)
      old_pids = @processes.map(&:pid)

      return false if (new_pids & old_pids) == new_pids

      @processes.select! { |p| new_pids.include?(p.pid) }
      new_processes_list.reject! { |p| old_pids.include?(p.pid) }

      @processes += new_processes_list

      @processes.sort_by!(&:pid)
      auto_select_process
      notify_observers
      true
    end

    def selected_process_index
      @processes.index(&:selected)
    end

    def select_process(index)
      @processes.each { |p| p.selected = false }
      @processes[index].selected = true
    end

    def auto_select_process
      @processes.each { |p| p.selected = false }
      @processes[0].selected = true
    end

    def select_next_process
      index = selected_process_index
      @processes[index].selected = false
      @processes[index + 1].selected = true
      notify_observers
    end

    def select_previous_process
      index = selected_process_index
      @processes[index].selected = false
      @processes[index - 1].selected = true
      notify_observers
    end

    def kill_selected_process
      index = selected_process_index
      pid = @processes[index].pid
      `kill -9 #{pid}`
    end
  end
end
