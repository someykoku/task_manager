# frozen_string_literal: true

module Beholder
  module Producer
    def add_observer(observer)
      observers << observer
    end

    def observers
      @observers ||= []
    end

    def notify_observers
      observers.each do |observer|
        observer.update(self)
      end
    end
  end
end
