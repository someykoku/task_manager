module Application

  def self.run
    Input.raw_mode
    loop do
      current_controller.key_pressed(Input.read_input)
      process_table.refresh!
      sleep 0.1
      `clear`
    end
  rescue StandardError => e
    p e
  ensure
    Input.skip_raw_mode
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
