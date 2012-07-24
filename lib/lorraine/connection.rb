module Lorraine
  
  class Connection
    
    def initialize
    end

    def write_message(msg)
      puts "Writing message unimplemented."
    end
    
    def display_pixels(pixel_array)
      commands = []
      pixel_array.each_with_index do |pixel, i|
        commands << Lorraine::Message.new(:set_pixel, i, pixel[0], pixel[1], pixel[2])
      end
      commands << Lorraine::Message.new(:refresh)
      commands.each do |command|
        self.write_message command
        #self.read_line
      end
    end
    
    def display_image(img)
      @current_image = img
      display_pixels img.rgb_pixels(4095)
    end
    
    def animate_to_image(other_image, duration = 1, fps = 24)
      frame_time = duration.to_f / fps.to_f
      frame_count = duration * fps
      frames = Lorraine::Image.frames_between(@current_image, other_image, frame_count)
      frames.each do |frame|
        display_image frame
        sleep frame_time
      end
    end
    
    def sever!
      
    end
        
  end
  
end
