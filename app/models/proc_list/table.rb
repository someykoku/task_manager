# frozen_string_literal: true

require_relative '../../../lib/beholder/producer'

module ProcList
  class Table
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
      notify_observers
      true
    end
  end
end

