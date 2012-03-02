# coding: Windows-31J
require "dxruby"

class Endroll
  BACKGROUND_IMG = File.join(File.dirname(__FILE__), "images", "tonosama.png")
  
  def initialize
    	@i = 0
  	@pushed_space = false
  	@playing = false
  	@sound = Resources.sound("click.wav" )
  	@sound_bace = Sound.new( File.join(File.dirname(__FILE__),"endroll.wav" ))

  	@title_image = Image.load(BACKGROUND_IMG)
  	txt_file =  File.join(File.dirname(__FILE__), "ending_roll.txt")#�e�L�X�g�̃p�X
    str = File.read(txt_file).split(/\n/)
  	
    txt = Text.new("<< PRESS ESCAPE KEY >>", 
          color: [255, 0, 0],  # �t�H���g�F�����F�ɐݒ�
          x:280,y: 500, bold: true)
    @sw = SwStyleText.new(str,txt,font_name:'�l�r ����',bold: true)
  end

  # �V�[���`��
  # �X�y�[�X�L�[���������ꂽ��V�[����؂�ւ��ăQ�[���V�[���ɑJ�ڂ���
  def play
    if @playing == false 
      @sound_bace.setVolume(250)
      @sound_bace.play
      @playing = true
    end
    Window.draw(0, 0,@title_image)
    @sw.draw

    if @pushed_space
      @i = @i + 1
      if @i >= 200
        Scene.exit
        @sound_bace.stop
        @sound.stop

      end
    end
    
    if Input.keyPush?(K_SPACE)
      @sound.setVolume(250)
      @sound.play
      @pushed_space = true
    end
    
  end
end

