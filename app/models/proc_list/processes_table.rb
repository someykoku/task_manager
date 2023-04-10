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
      Application::ApplicationLogger.info('Refreshing process table')
      new_processes_list = Process.list

      Application::ApplicationLogger.info('Comparing process lists')
      new_pids = new_processes_list.map(&:pid)
      old_pids = @processes.map(&:pid)

      Application::ApplicationLogger.info('Returning false if (new_pids & old_pids) == new_pids')
      return false if (new_pids & old_pids) == new_pids

      Application::ApplicationLogger.info('Removing old processes')
      @processes.select! { |p| new_pids.include?(p.pid) }

      Application::ApplicationLogger.info('Adding new processes')
      new_processes_list.reject! { |p| old_pids.include?(p.pid) }

      @processes += new_processes_list

      Application::ApplicationLogger.info('Sorting processes')
      @processes.sort_by!(&:pid)

      Application::ApplicationLogger.info('Auto selecting process')
      auto_select_process

      Application::ApplicationLogger.info('Notifying observers')
      notify_observers

      Application::ApplicationLogger.info('Returning true')
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
      return if @processes.any?(&:selected)

      @processes.each { |p| p.selected = false }
      @processes[0].selected = true
    end

    def select_next_process
      index = selected_process_index
      @processes[index].selected = false
      if index == @processes.length - 1
        @processes[0].selected = true
      else
        @processes[index + 1].selected = true
      end

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
      @processes[index].kill
      sleep 1
      refresh!
    end
  end
end
