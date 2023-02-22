module Application
  class BaseController

    def initialize(model)
      @model = model
    end

    def key_pressed(key)
      public_send "#{key}_pressed"
    rescue NoMethodError
    end
  end
end