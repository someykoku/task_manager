# frozen_string_literal: true

require 'io/console'

module Application
  module Input

    def self.raw_mode 
      system('stty raw -echo')
    end
    
    # def read_input
    #   STDIN.read_nonblock(1).ord
    # rescue StandardError
    #   nil
    # end

    def self.read_input
      input = STDIN.read_nonblock(1)
      input == "\e" ? STDIN.read_nonblock(2, exception: false) : input
    rescue IO::WaitReadable
      nil
    end
    

    def self.skip_raw_mode 
      system('stty -raw echo')
    end

  end
end
      