# frozen_string_literal: true

require 'awesome_print'
require 'sys/proctable'
require 'pry'
require_relative '../../../lib/beholder/observer'

# create module to hold the class
module ProcList
  # create class to hold the process information
  class Process
    include Beholder::Observer
    attr_accessor :pid, :pname, :ram, :selected

    def initialize(pid, pname, ram = 0)
      @selected = false
      @pid = pid.to_i
      @pname = pname.to_s
      @ram = ram.to_f
    end

    def self.list
      processes = `ps -eo pid,comm,%mem,%cpu --sort=-%cpu | awk '{OFS=\"</>\";print $1,$2,$3,$4}'`.split("\n")
      processes.shift
      processes.map do |process|
        pid, pname, ram, cpu = process.split('</>')
        new(pid, pname, ram)
      end
    end

    def kill
      `kill -9 #{@pid}`
      sleep 1
    end
  end
end
