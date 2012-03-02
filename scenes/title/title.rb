# coding: Windows-31J
require "dxruby"

class Title
  BACKGROUND_IMG1 = File.join(File.dirname(__FILE__), "images", "shashin.png")
  BACKGROUND_IMG2 = File.join(File.dirname(__FILE__), "images", "logo2.png")
  
  def initialize
    setup()
  end
  
  def setup
  	@i = 0
  	@playing = false
  	@pushed_space = false
  	@sound_bace = Sound.new( File.join(File.dirname(__FILE__),"opening.wav" ))
  	@sound = Sound.new( File.join(File.dirname(__FILE__),"click.wav" ))
  
        @title_image1 = Image.load(BACKGROUND_IMG1)
  	@title_image2 = Image.load(BACKGROUND_IMG2)
  	txt_file =  File.join(File.dirname(__FILE__), "opening_roll.txt")#テキストのパス
	str = File.read(txt_file).split(/\n/)

        txt = Text.new("<< PRESS SPACE KEY >>", 
             color: [255, 0, 0],  # フォント色を黄色に設定
             x:280,y: 500, bold: true)
        @sw = SwStyleText.new(str,txt,font_name:Resources::Font::Name,bold: true)
        
     Scene.common.score = 0
  end

  # シーン描画
  # スペースキーが押下されたらシーンを切り替えてゲームシーンに遷移する
  
  
  def play
    if @playing == false 
      @sound_bace.setVolume(240)
      @sound_bace.play
      @playing = true
    end
    
    Window.draw(0, 0,@title_image1)
    Window.draw(100, 30,@title_image2)
    @sw.draw
    
    if @pushed_space
      @i = @i + 1
      if @i >= 20
        Scene.set_current_scene(:stage_sample)
        #Scene.set_current_scene(:stage_sample_2)
        @sound_bace.stop
        @sound.stop
      end
    end
    
    if Input.keyPush?(K_SPACE)
      
      @sound.setVolume(240)
      @sound.play
      
      @pushed_space = true
    end
    
  end
end
