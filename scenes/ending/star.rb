#coding:shift_jis

class PictureStar
	attr_accessor :x,:y
	FontName = '�l�r �S�V�b�N'
	FontSize = 55
	
	def initialize(snum)
# �`���ׂ����̐����C���X�^���X�ϐ��ɕێ�
        @num_of_stars = snum
	end
	
	def draw
# �����ŊǗ����Ă�����W�ɐ���`��
		font = Font.new(FontSize,FontName)
		@image = Image.new(font.getWidth("��"), font.size)
                @image2 = Image.new(font.getWidth("��"), font.size)
     
                color = [255,255,0]
		@image.drawFont(0,0,"��",font,color)
                @image2.drawFont(0,0,"��",font,color)
		# 0...5�ŌJ�Ԃ��ȉ���`��
                (0 ... 5).each do|i|
                  x = 470+(i * @image.width)
                  y = 250
		  if i < @num_of_stars
                        Window.draw(x,y,@image)
		  else
                        Window.draw(x,y,@image2)
		  end
         	end
		
	end
end



#require 'dxruby'
#Window.loop do
#  PictureStar.new(3).draw(0, 20)
#end
