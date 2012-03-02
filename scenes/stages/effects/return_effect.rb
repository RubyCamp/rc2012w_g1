class ReturnEffect < EffectBase
  def initialize(director, x, y, opts = {})
    super
#    if x2 > 0
#      @dx = 5
#    else
#      @dx = -5
#    end
    @dx = 0
    @dy = -1.35
    @k = 0.1
    @round
    image_file = File.join(File.dirname(__FILE__), "..", "images", "UFO.png")
    @image = Image.load(image_file)
    @image.setColorKey([0, 0, 0])
#    @g = 0.3
#    @angle = 0
  end

  def move
    @dx = @k*Math.sin(@k) + 0.1*@k
    @x += @dx
    @y += @dy
    @k += 0.1
#    if @angle <= 360
#      @angle += 10
#    else
#      @angle = 0
#    end
    remove if @y < 0
  end
  
  def draw
    Window.drawEx(@x, @y, @image, :angle => 20)
  end
end
