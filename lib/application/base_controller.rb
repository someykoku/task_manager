# frozen_string_literal: true

module Application
  class BaseController
    def initialize(model)
      @model = model
    end

    def key_pressed(key)
      public_send "#{key}_pressed" if respond_to? "#{key}_pressed"
    end
  end
end
