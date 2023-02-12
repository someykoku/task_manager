# frozen_string_literal: true

require 'io/console'

module Application
  module Input
    def self.listen(&block)
      Thread.new do
        loop do
          # Check if a key was pressed.
          if IO.select([$stdin], [], [], 0)
            # Read the key from standard input.
            key = $stdin.getch
            # Pass the key to the block.
            block.call(:key, key)
          end

          # Check if a mouse click occurred.
          if IO.select([], [$stdout], [], 0)
            # Read the mouse click from standard output.
            click = $stdin.read_nonblock(6)
            # Parse the mouse click data.
            type = click.unpack1('c')
            button = click.unpack1('x3c')
            x = click.unpack1('x4s<')
            y = click.unpack1('x6s<')
            # Pass the mouse click to the block.
            block.call(:mouse, { type: type, button: button, x: x, y: y })
          end

          # Sleep briefly to avoid consuming too much CPU time.
          sleep 0.01
        end
      end

      # Return the created thread.
    end
  end
end
