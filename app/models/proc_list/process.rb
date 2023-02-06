require 'awesome_print'
require 'sys/proctable'

#create module to hold the class
module ProcList

  #create class to hold the process information
  class Process

    attr_accessor :pid, :pname

    def initialize(pid, pname)
      @pid = pid
      @pname = pname
    end

    def self.list
      processes_list = Sys::ProcTable.ps.map do |process|
        self.new(process.pid, process.name)
      end
    end
  end
end
