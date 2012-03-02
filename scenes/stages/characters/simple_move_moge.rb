
module SimpleMoveMoge
  def x_move
    @x_move ||= Fiber.new do
      loop do
        16.times{ Fiber.yield(4)}
        16.times{ Fiber.yield(-4)}
      end
    end
  end
  
  def y_move
    @y_move ||= Fiber.new do
      loop do
        16.times{ Fiber.yield(4)}
        16.times{ Fiber.yield(-4)}
      end
    end
  end
  
  def move
    super
    @x += x_move.resume
    @y += y_move.resume
  end
end
