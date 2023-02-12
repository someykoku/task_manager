require 'io/console'

module Application
  module Input
    def self.listen(&block)
      thread = Thread.new do
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
            type = click.unpack('c')[0]
            button = click.unpack('x3c')[0]
            x = click.unpack('x4s<')[0]
            y = click.unpack('x6s<')[0]
            # Pass the mouse click to the block.
            block.call(:mouse, {type: type, button: button, x: x, y: y})
          end

          # Sleep briefly to avoid consuming too much CPU time.
          sleep 0.01
        end
      end

      # Return the created thread.
      thread
    end
  end
end
