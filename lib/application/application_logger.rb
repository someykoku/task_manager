# frozen_string_literal: true

module Application
  # This class is responsible for logging messages to the console.
  # It is used by the Application class to log messages.
  # Using ruby logger that should write logs to 'log/application.log'
  # and 'log/errpr.log' files.

  module ApplicationLogger
    def self.logger
      @logger ||= Logger.new('log/application.log')
    end

    def self.error_logger
      @error_logger ||= Logger.new('log/error.log')
    end

    def self.info(message)
      logger.info(message)
    end

    def self.error(message)
      error_logger.error(message)
    end
  end
end
