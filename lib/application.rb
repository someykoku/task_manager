# frozen_string_literal: true

module Application
  def self.run
    Input.init
    loop do
      ApplicationLogger.info('Getting input')
      current_controller.key_pressed(Input.read_input)
      ApplicationLogger.info('Refreshing process table')
      process_table.refresh!
      ApplicationLogger.info("Step Done! Current controller: #{current_controller.class.name}")
      sleep 0.1
    end
  rescue StandardError => e
    puts e
  ensure
    exit
  end

  def self.controllers
    @controllers ||= {
      process_table_controller: ProcessTableController.new(process_table)
    }
  end

  def self.current_controller
    @current_controller ||= controllers[:process_table_controller]
  end

  def self.process_table
    unless @process_table
      @process_table = ProcList::ProcessTable.new
      @process_table.add_observer TableView.new(@process_table)
    end
    @process_table
  end
end
