class EffectBase
  attr_accessor :z
  
  def initialize(director, x, y, z, opts = {})
    @director = director
    @x, @y, @z = x, y, z
  end

  def move
  end

  def remove
    @director.delete_item self
  end

  def draw
    Window.draw(@x, @y, @image)
  end
end