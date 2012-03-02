


class Picture
  BasePath = File.join(File.dirname(__FILE__),'..', 'images')
  
  attr_accessor :x, :y, :z,:image
  
  def initialize(image, x = 0, y = 0, z = 0)
    case
    when image.kind_of?(Image)
      @image = image
    else
      #puts BasePath
      @image = Image.load(File.join(BasePath,image))
    end
    
    @x = x; @y = y; @z = z
  end
  
  def draw
    Window.draw(@x,@y,@image)
  end
end