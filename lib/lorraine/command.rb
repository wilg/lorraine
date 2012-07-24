module Lorraine
  
  require "thor"
  require "thin"
  
  class CommandLine < Thor
    
    desc "testpattern", "Display a test pattern."
    def testpattern
      say "nice to meet you", :red
      ask("What is your favorite Neopolitan flavor?", :limited_to => ["strawberry", "chocolate", "vanilla"])

      
      puts "I'm a thor task!"
    end
    
    desc "server <command>", "install one of the available apps"
    method_option :port, type: :boolean, aliases: "-p", desc: "Port this server will be at.", default: 1964
    def server(command)
      puts "command: #{command}, options: #{options}"
      if command.to_sym == :start
        Lorraine::Server.start(options[:port])
      end
    end
    
    desc "set <pixel> <r> <g> <b>", "light up a pixel. rgb values from 0.0 - 1.0"
    method_option :remote, type: :boolean, aliases: "-r", desc: "Set the pixel over the network.", default: false
    def set(pixel, r, g, b)
      m = Lorraine::Message.new :set_pixel, pixel, (r * 4095).to_i, (g * 4095).to_i, (b * 4095).to_i
      if options[:remote]
        Lorraine::Client.send_message(m)
      else
        c = Lorraine::Connection.new
        puts "Waiting 5 seconds..."
        sleep 5
        c.write_message(m)
      end
    end
    
    desc "debug", "Misc. debuggins"
    def debug
      c = Lorraine::Message.new :set_pixel, 2, 0, 0, 4095
      j = c.to_json
      puts "json: #{j}"
      puts Lorraine::Message.from_json j
    end
    
        # 
        # def self.testpattern
        #   # puts "command: #{command}"
        #   # puts "   args: #{args}"
        #   # puts "Starting connection... with serialort #{SerialPort::VERSION}"
        #   
        #   # Lorraine::Connection.new
        #   # c = Lorraine::Message.new :display_pixel, 2, 0, 0, 4095
        #   # puts "command: #{c}"
        #   # puts "binary: #{c.to_binary}"
        #   # puts "back in: #{Lorraine::Message.decode c.to_binary}"
        #   
        #   connection = Lorraine::Connection.new "/dev/tty.usbserial-A6008RQE"
        #   puts "Waiting 5 seconds..."
        #   sleep 5
        #   puts "Writing..."
        # 
        # 
        #   img = Lorraine::Image.new(5, 1)
        #   img2 = Lorraine::Image.new(5, 1)
        #   
        #   # img.clear!([1, 0, 0])
        #   img.rgb_pixels = [[1, 0, 0], [0, 1, 0], [0, 0, 1], [1, 1, 1], [0.5, 1, 0.5]]
        #   
        #   img2.rgb_pixels = [[0, 0, 1], [1, 0, 0], [1, 0, 0], [1, 0, 0], [1, 0, 0]]
        #   # img2.clear!([0, 1, 0])
        #   
        #   
        #   # img.rgb_pixels = [[1, 0, 0], [0, 1, 0], [0, 0, 1], [1, 1, 1], [0.5, 1, 0.5]]
        #   # img.rgb_pixels = [[1, 0, 0], [1, 0, 0], [1, 0, 0], [1, 0, 0], [1, 0, 0]]
        #   
        #   # full_colors = [[1, 0, 0], [0, 1, 0], [0, 0, 1], [0, 0, 0], [1, 1, 1]]
        # 
        #   connection.display_image img
        #   
        #   # i = 0
        #   while true
        #     # full_colors.rotate!
        #     # img.clear!(full_colors.first)
        #     # puts img.rgb_pixels.to_s
        # 
        #     connection.animate_to_image img2, 2, 200
        #     connection.animate_to_image img,  2, 200
        #     # i += 1
        #   end
        #   connection.sever!
        #   
        #   
        # end
    
  end
  
end