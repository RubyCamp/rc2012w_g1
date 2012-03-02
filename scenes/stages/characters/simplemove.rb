require_relative "character"
require "dxruby"
require "dxrubyex"
module SimpleMove
  #def self.included(base); puts "#{base}.included #{self}" end
  
  def move
    #puts "move"
    super
    if @mvstt == :hide && rand < 0.01 #‚±‚Ì’l‚ð•Ï‚¦‚é‚±‚Æ‚ÅoŒ»—¦‚ª•Ï‚í‚é
      @mvstt = :out
      @mvtimes = @speed
    end
    if @mvstt == :out
      @mv ||= Math.sqrt(@mx ** 2 + @my ** 2).round
      @x += (((@mv / @speed) * @mx) / @mv).round
      @y += (((@mv / @speed) * @my) / @mv).round
      @mvtimes -= 1
      #puts "#@x #@y #@tempx #@tempy"
      if @mvtimes == 0
        @mvstt = :stop
        @waittime = rand(300) + 1
      end
    end
    if @mvstt == :stop
      if @waittime == 0
        @mvstt = :back
        @mvtimes = @speed
      else
        @waittime -= 1
      end
    end
    if @mvstt == :back
      @x -= (((@mv / @speed) * @mx) / @mv).round
      @y -= (((@mv / @speed) * @my) / @mv).round
      @mvtimes -= 1
      if @mvtimes == 0
        @mvstt = :hide
      end
    end
  end
end