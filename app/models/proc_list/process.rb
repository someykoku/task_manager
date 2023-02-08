require 'awesome_print'
require 'sys/proctable'
require 'pry'
require_relative '../../../lib/beholder/observer.rb'


#create module to hold the class
module ProcList

  #create class to hold the process information
  class Process
    include Beholder::Observer
    

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
