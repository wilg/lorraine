module Lorraine
  
  class Command
    
    def self.run(command, args)
      # puts "command: #{command}"
      # puts "   args: #{args}"
      # puts "Starting connection... with serialort #{SerialPort::VERSION}"
      
      # Lorraine::Connection.new
      # c = Lorraine::Message.new :display_pixel, 2, 0, 0, 4095
      # puts "command: #{c}"
      # puts "binary: #{c.to_binary}"
      # puts "back in: #{Lorraine::Message.decode c.to_binary}"
      
      connection = Lorraine::Connection.new "/dev/tty.usbserial-A6008RQE"
      puts "Waiting 5 seconds..."
      sleep 5
      puts "Writing..."


      img = Lorraine::Image.new(5, 1)
      img2 = Lorraine::Image.new(5, 1)
      
      # img.clear!([1, 0, 0])
      img.rgb_pixels = [[1, 0, 0], [0, 1, 0], [0, 0, 1], [1, 1, 1], [0.5, 1, 0.5]]
      
      img2.rgb_pixels = [[0, 0, 1], [1, 0, 0], [1, 0, 0], [1, 0, 0], [1, 0, 0]]
      # img2.clear!([0, 1, 0])
      
      
      # img.rgb_pixels = [[1, 0, 0], [0, 1, 0], [0, 0, 1], [1, 1, 1], [0.5, 1, 0.5]]
      # img.rgb_pixels = [[1, 0, 0], [1, 0, 0], [1, 0, 0], [1, 0, 0], [1, 0, 0]]
      
      # full_colors = [[1, 0, 0], [0, 1, 0], [0, 0, 1], [0, 0, 0], [1, 1, 1]]
    
      connection.display_image img
      
      # i = 0
      while true
        # full_colors.rotate!
        # img.clear!(full_colors.first)
        # puts img.rgb_pixels.to_s

        connection.animate_to_image img2, 2, 200
        connection.animate_to_image img,  2, 200
        # i += 1
      end
      connection.sever!
      
    end
    
  end
  
end