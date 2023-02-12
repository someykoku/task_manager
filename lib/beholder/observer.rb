# frozen_string_literal: true

module Beholder
  module Observer
    def subscribe_to(producer)
      producer.add_observer(self)
    end
  end
end
