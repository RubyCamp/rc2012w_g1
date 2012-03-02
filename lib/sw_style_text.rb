#coding:Windows-31J


class SwStyleText

  def initialize(roll_text_ary, announce_text, opt = {})
    @font_size = opt[:font_size] || 24           # �`��t�H���g�̃T�C�Y
    @color     = opt[:color] || [255, 255, 255]   # �`��F
    @font_name = opt[:font_name]  || "�l�r �S�V�b�N"
    @bold      = opt[:bold] || false
     
    @font = Font.new(@font_size, @font_name,:weight => @bold)
    
    #��Ԓ���������
    @str = roll_text_ary.max_by{|i| @font.getWidth( i )}
    
    @roll_text_ary = roll_text_ary
    @image    ||= Image.new( @font.getWidth( @str ),(@roll_text_ary.size * @font.size) )#,@color) #�����̑傫�����o��������
    @image.setColorKey([0,0,0])

    @x = 0
    @y = 100
    @count = 0.0
    @dy = @font_size * 25
    @announce_text = announce_text
    #Text.new("<< PRESS ESCAPE KEY >>", 
    #         color: [255, 0, 0],  # �t�H���g�F�����F�ɐݒ�
    #         x:280,y: 500, bold: true)

    @flag = true
  end
  
  def draw

    @image.fill([0,0,0])
    @image.setColorKey([0,0,0])
    @roll_text_ary.each_with_index{|line,i| 
      @image.drawFont(0, (i * @font_size) + @dy, line, @font, @color)
    }
	@dy -= 1
  	
  	Window.drawMorph(@x + 200,@y,
  	                 @x + Window.width - 200, @y,
  	                 @x + Window.width + 200,@y + Window.height,
  	                 @x - 200,@y + Window.height,
  	                 @image,dividex:10, dividey:10)
	if @dy <= -(@roll_text_ary.size * @font_size)-500
	
		@flag = !@flag if (@dy % 10) == 0 
		
		if @flag
   			@announce_text.draw
   		end
	end
  end
end
