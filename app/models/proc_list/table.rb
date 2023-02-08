require_relative '../../../lib/beholder/producer.rb'

module ProcList
  class Table

    include Beholder::Producer
    
    attr_reader :processes

    def initialize
      refresh!
    end

    def refresh!
      @processes = Process.list
      notify_observers
    end
  end

end