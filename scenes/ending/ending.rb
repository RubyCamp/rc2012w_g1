# coding: Windows-31J

require_relative 'star'

class Ending
    BACKGROUND_IMG = File.join(File.dirname(__FILE__), "images", "shashin.png")
   # ENDING_ROLL_TEXT = File.join(File.dirname(__FILE__), "ending_roll.txt")
   
   #画像の表示
   

   
    def setup
      #背景画像の読み込み
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

      #得点を漢字に変換する
      jns = ""
      if n == 0
        jns = "零"
      else
	      n.to_s.each_char.reverse_each.each_with_index do|val,i|
	        
	        
	        case val.to_i
	        when 0; next
	        when 1; val = "一"
	        when 2; val = "二"
	        when 3; val = "三"
	        when 4; val = "四"
	        when 5; val = "五"
	        when 6; val = "六"
	        when 7; val = "七"
	        when 8; val = "八"
	        when 9; val = "九"
	        end
	        
	        jns = val + to_keta(i) + jns
	      end
      end
#      numberArray = ["一","二","三","四","五","六","七","八","九"]
#      jns.gsub("1", "一")
#      jns.gsub("2", "二")
#      jns.gsub("3", "三")
#      jns.gsub("4", "四")
#      jns.gsub("5", "五")
#      jns.gsub("6", "六")
#      jns.gsub("7", "七")
#      jns.gsub("8", "八")
#      jns.gsub("9", "九")
#      jns.gsub("0", "")
      
#      @japaneseNumber = jns

      #scoreの表示
      str = "得点 #{jns}"      
      #LEVELの表示
      strs = "階級 #{starNumber}"

      @describe2_text = Text.new(strs, x: 60, y: 230, font_size: 80, color: [255, 255, 0], bold: true)

      @describe_text = Text.new(str, x: 200, y: 380, font_size: 40, color: [255, 255, 0], bold: true)

      @announce_text = Text.new("メニューに戻る", color: [255, 255, 0], font_size: 20, x: 600, y: 550, bold: true)

      @announce_text2 = Text.new("どろん", color: [255, 255, 0], font_size: 50, x: 350, y: 500, bold: true)
      
      #エンディングロールとして流すテキストを配列に格納する
      #@staff_roll = File.read(ENDING_ROLL_TEXT).split(/\n/)
      
      #定義したスタッフロールを、画面最下部から最上部までスクロールさせる。
      #その際、色は黄色で描画するように設定を変えてみる。
      #@scroll_text = ScrollText.new(@staff_roll, :color => [255, 255, 0])


      @picture_star = PictureStar.new(starNumber)
       
    end

    def to_keta(n)
      d,m = n.divmod(4)
      
      case m
      when 1; "十"
      when 2; "百"
      when 3; "千"
      when 0
        [
          "",
          "万",
          "億",
          "兆",
          "京"
        ].at(d)
      end
    end


    
    def draw
      #背景画像表示後に、スクロールするテキストを描画する
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
    # シーン描画
    # スペースキーまたはエンターキーが押下されたらプログラムを終了する
    def play
      draw  # エンディング画面を描画
      if Input.keyPush?(K_RETURN)
          Scene.set_current_scene(:endroll)
      elsif Input.keyPush?(K_SPACE)
          Scene.set_current_scene(:title)
          #Scene.set_current_scene(:game)
          #puts "実行します"
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