# coding: Windows-31J

require_relative 'star'

class Ending
    BACKGROUND_IMG = File.join(File.dirname(__FILE__), "images", "shashin.png")
   # ENDING_ROLL_TEXT = File.join(File.dirname(__FILE__), "ending_roll.txt")
   
   #�摜�̕\��
   

   
    def setup
      #�w�i�摜�̓ǂݍ���
      @ending_image = Image.load(BACKGROUND_IMG)
      image_file = File.join(File.dirname(__FILE__), "images", "result.png")
      @image = Image.load(image_file)
      
      n = Scene.common.score
      
      if n <= 2000
        starNumber = 1
      elsif n <= 4000
        starNumber = 2
      elsif n <= 6000
        starNumber = 3
      elsif n <= 8000
        starNumber = 4
      else
        starNumber = 5
      end

      #���_�������ɕϊ�����
      jns = ""
      if n == 0
        jns = "��"
      else
	      n.to_s.each_char.reverse_each.each_with_index do|val,i|
	        
	        
	        case val.to_i
	        when 0; next
	        when 1; val = "��"
	        when 2; val = "��"
	        when 3; val = "�O"
	        when 4; val = "�l"
	        when 5; val = "��"
	        when 6; val = "�Z"
	        when 7; val = "��"
	        when 8; val = "��"
	        when 9; val = "��"
	        end
	        
	        jns = val + to_keta(i) + jns
	      end
      end
#      numberArray = ["��","��","�O","�l","��","�Z","��","��","��"]
#      jns.gsub("1", "��")
#      jns.gsub("2", "��")
#      jns.gsub("3", "�O")
#      jns.gsub("4", "�l")
#      jns.gsub("5", "��")
#      jns.gsub("6", "�Z")
#      jns.gsub("7", "��")
#      jns.gsub("8", "��")
#      jns.gsub("9", "��")
#      jns.gsub("0", "")
      
#      @japaneseNumber = jns

      #score�̕\��
      str = "���_ #{jns}"      
      #LEVEL�̕\��
      strs = "�K�� #{starNumber}"

      @describe2_text = Text.new(strs, x: 60, y: 230, font_size: 80, color: [255, 255, 0], bold: true)

      @describe_text = Text.new(str, x: 200, y: 380, font_size: 40, color: [255, 255, 0], bold: true)

      @announce_text = Text.new("���j���[�ɖ߂�", color: [255, 255, 0], font_size: 20, x: 600, y: 550, bold: true)

      @announce_text2 = Text.new("�ǂ��", color: [255, 255, 0], font_size: 50, x: 350, y: 500, bold: true)
      
      #�G���f�B���O���[���Ƃ��ė����e�L�X�g��z��Ɋi�[����
      #@staff_roll = File.read(ENDING_ROLL_TEXT).split(/\n/)
      
      #��`�����X�^�b�t���[�����A��ʍŉ�������ŏ㕔�܂ŃX�N���[��������B
      #���̍ہA�F�͉��F�ŕ`�悷��悤�ɐݒ��ς��Ă݂�B
      #@scroll_text = ScrollText.new(@staff_roll, :color => [255, 255, 0])


      @picture_star = PictureStar.new(starNumber)
       
    end

    def to_keta(n)
      d,m = n.divmod(4)
      
      case m
      when 1; "�\"
      when 2; "�S"
      when 3; "��"
      when 0
        [
          "",
          "��",
          "��",
          "��",
          "��"
        ].at(d)
      end
    end


    
    def draw
      #�w�i�摜�\����ɁA�X�N���[������e�L�X�g��`�悷��
      Window.draw(0, 0, @ending_image)
                    
      Window.drawEx(300, 30, @image,
                    :scalex => 1.5,
                    :scaley => 1.5)
      #@scroll_text.draw
      @describe_text.draw
      @announce_text.draw
      @describe2_text.draw
      @announce_text2.draw
    
      @picture_star.draw
      
     end
    # �V�[���`��
    # �X�y�[�X�L�[�܂��̓G���^�[�L�[���������ꂽ��v���O�������I������
    def play
      draw  # �G���f�B���O��ʂ�`��
      if Input.keyPush?(K_RETURN)
          Scene.set_current_scene(:endroll)
      elsif Input.keyPush?(K_SPACE)
          Scene.set_current_scene(:title)
          #Scene.set_current_scene(:game)
          #puts "���s���܂�"
      end
    end
end


class Ending
 alias old_play play
 def play
   old_play
   if Input.mousePush? M_LBUTTON
      Scene.set_current_scene(:endroll) if @announce_text2.include?(Input.mousePosX,Input.mousePosY) 
      Scene.set_current_scene(:title)   if @announce_text.include?(Input.mousePosX,Input.mousePosY)
   end
 end
end