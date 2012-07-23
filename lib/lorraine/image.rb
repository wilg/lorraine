module Lorraine
  
  # require 'colorist'
  
  
  class Image
          
    attr_accessor :pixels
    attr_accessor :width
    attr_accessor :height
    
    def self.frames_between(a, b, steps = 10)
      raise "Different sized images for frames_between" if a.count != b.count
      pixel_frames = []
      a.pixels.each_with_index do |a_px, i|
        b_px = b.pixels[i]
        pixel_frames << a_px.gradient_to(b_px, steps)
      end
      pixel_frames.transpose.map do |frame|
        img = Lorraine::Image.new(a.width, a.height)
        img.pixels = frame
        img
      end
    end
    
    def initialize(w, h)
      self.width = w
      self.height = h
    end
    
    def count
      self.width * self.height
    end
    
    # 0.0 - 1.0
    def rgb_pixels=(rgb, percent = true)
      self.pixels = rgb.map{ |px| Colorist::Color.from_rgb(px[0], px[1], px[2], percent: percent) }
    end
    
    def clear!(rgb, percent = true)
      px = []
      count.times{ px <<  Colorist::Color.from_rgb(rgb[0], rgb[1], rgb[2], percent: percent) }
      self.pixels = px
    end
    
    def rotate!
      @pixels.rotate!
    end
    
    def rgb_pixels(upper_limit = 1)
      self.pixels.map {|px| [px.r.to_f / 255.0 * upper_limit, px.g.to_f / 255.0  * upper_limit, px.b.to_f / 255.0  * upper_limit] }
    end
    
  end
  
  class Pixel
    
    attr_accessor :color
    
  end
  
end
