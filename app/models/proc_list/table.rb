require_relative '../../../lib/beholder/producer.rb'

module ProcList
  class Table

    include Beholder::Producer
    
    attr_reader :processes

    def initialize
      @processes = []
    end

#     def refresh!
#       new_processes = Process.list
#       new_process_pids = new_processes.map(&:pid)
#       existing_process_pids = @processes.map(&:pid)
      
#       terminated_process_pids = existing_process_pids - new_process_pids
#       @processes.reject! { |p| terminated_process_pids.include?(p.pid) }
      
#       new_processes.each do |process|
#         index = @processes.find_index { |p| p.pid == process.pid }
#         if index
#           @processes[index] = process
#         else
#           @processes << process
#         end
#       end
#       notify_observers
#     end
#   end
# end

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