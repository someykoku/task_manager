# frozen_string_literal: true

class ProcessTableController < Application::BaseController
  def q_pressed
    exit
  end

  def w_pressed
    @model.select_previous_process
  end

  def s_pressed
    @model.select_next_process
  end

  def x_pressed
    @model.kill_selected_process
  end
end
