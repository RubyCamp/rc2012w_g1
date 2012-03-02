class CrashEffect < EffectBase
  def initialize(director, x, y, z, opts = {})
    super
    image_file = File.join(File.dirname(__FILE__), "..", "images", "enemy_crashed.png")
    @image = Image.load(image_file)
    @image.setColorKey([0, 0, 0])
    @count = 0
    @alpha = 0
  #  @speed_x = 5
  #  @speed_y = 5
  end

  def move
  #  @x -= @speed_x
  #  @y -= @speed_y
    remove if @count >= 120
    @count += 1
    if @count % 5 == 0
      p @alpha
      case @alpha
      when 0 then
        @alpha = 255
      when 255 then
        @alpha = 0
        else
      end     
    end
 #   if @alpha == 0
 #     Window.draw(@x, @y, @image)
 #     Window.drawAlpha( @x, @y, @image, @alpha )
 #   end
 #   if @alpha == 255
 #     Window.draw(@x, @y, @image)
 #  Window.drawAlpha( @x, @y, @image, @alpha )
 #   end
 
  end
  
  def draw
    Window.drawAlpha( @x, @y, @image, @alpha )
  end
  def effect
    
  end
end
