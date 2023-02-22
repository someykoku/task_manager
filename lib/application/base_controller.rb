module Application
  class BaseController

    def initialize(model)
      @model = model
    end

    def key_press(key)
      public_send "#{key}_pressed"
    end
  end
end