class RotationEffect < EffectBase
  def initialize(director, x, y, z, dx, opts = {})
    super(director,x,y,z,opts)
#    if x2 > 0
#      @dx = 5
#    else
#      @dx = -5
#    end
    if dx < 0
      @dx = -20
    else
      @dx = 20
    end
    @dy = -38
    image_file = File.join(File.dirname(__FILE__), "..", "images", opts[:image_file] || "burnedalien.png")
    @image = Image.load(image_file)
    @image.setColorKey([0, 0, 0])
    @g = 3
    @angle = 0
  end

  def move
    @dy += @g
    @x += @dx
    @y += @dy
    if @angle <= 360
      @angle += 10
    else
      @angle = 0
    end
    remove if @y > Window.height
    #p @y
  end
  
  def draw
    Window.drawEx(@x, @y, @image,
                  :angle => @angle)
  end
end
