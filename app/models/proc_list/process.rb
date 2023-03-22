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
    attr_accessor :pid, :pname, :selected

    def initialize(pid, pname)
      @selected = false
      @pid = pid
      @pname = pname
    end

    def self.list
      Sys::ProcTable.ps.map { |process| new(process.pid, process.name) }
    end
  end
end
