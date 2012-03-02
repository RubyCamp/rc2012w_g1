class BombEffect < EffectBase
  def initialize(director, x, y, z, opts = {})
    super
    chip_size = 32
    image_file = File.join(File.dirname(__FILE__), "..", "images", "effect.png")
    temp = Image.load(image_file)
    chip_width  = temp.width / chip_size
    chip_height = temp.height / chip_size
    @images = Image.loadToArray(image_file, chip_width, chip_height)
    @images = @images.map{|i| i.setColorKey([0, 0, 0]) }
    @counter = 0.0
  end

  def move
    if @images.size - 1 <= @counter.to_i
      #p "remove"
      remove
    end
  end

  def draw
    Window.drawEx(@x, @y, @images[@counter.to_i])
    #p @counter
    @counter += 0.5
  end
end
