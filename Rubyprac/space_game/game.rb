require 'hasu'

class Game < Hasu::Window
  Hasu.load './Player.rb'
  Hasu.load './Star.rb'
  Hasu.load './MiniStar.rb'

  def initialize
    super 640, 480, false
  end

  def reset
    self.caption = "Star Collector"
    @player = Player.new
    @timer = 0
    @star_list = []
    @explosions = []
    @background_image = Gosu::Image.new("./space.png", :tileable => true)
    @font = Gosu::Font.new(20)
    @beep = Gosu::Sample.new("./beep.wav")
    @score = 0
    @menu = true
  end

  def update
    if @menu
      if Gosu::button_down?(Gosu::KbSpace)
        @menu = false
      end
    else
      @timer += 1
      #if @timer % 100 == 0 && @star_list.length < 10
      if @timer % 50 == 0 && @star_list.length < 19
        loop do
          new_star = Star.new
          star_star_collision = false
          @star_list.each do |star|
            if Gosu::distance(star.x, star.y, new_star.x, new_star.y) < 100
              star_star_collision = true
              break
            end
          end
          unless star_star_collision
            @star_list << new_star
            break
          end
        end
      end
      #puts Gosu::distance(@new_star.x, @new_star.y, @player.x, @player.y)
      if Gosu::button_down?(Gosu::KbUp)
        @player.accelerate
      end
      if Gosu::button_down?(Gosu::KbDown)
        @player.decelerate
      end
      if Gosu::button_down?(Gosu::KbLeft)
        @player.turn_left
      end
      if Gosu::button_down?(Gosu::KbRight)
        @player.turn_right
      end
      @player.move
      collect_stars
      @explosions.each do |mini_stars|
        mini_stars.each do |mini_star|
          mini_star.move
          if mini_star && @timer > (mini_star.birthday + 400)
            @explosions.delete(mini_stars)
          end
        end
      end

    end
  end

  def draw
    @background_image.draw(0, 0, 0)
    if @menu
      @font.draw("Welcome to Star Collector", 90, 150, 100, 2.0, 2.0, 0xff_ffff00)
      @font.draw("Press Space to start", 140, 200, 100, 2.0, 2.0, 0xff_ff0000)
    else
      @font.draw("Score: #{@score}", 10, 10, 100, 1.0, 1.0, 0xff_ffff00)
      @font.draw("Stars: #{@star_list.length}", 10, 30, 100, 1.0, 1.0, 0xff_ff0000)
      @star_list.each {|star| star.draw}
      @explosions.each do |mini_stars|
        mini_stars.each {|star| star.draw}
      end
      @player.draw
    end
  end

  def collect_stars
    @star_list.each do |star|
      if Gosu::distance(@player.x, @player.y, star.x, star.y) < 35
        @score += 10
        @beep.play
        create_mini_stars(star.x, star.y)
        @star_list.delete(star)
      end
    end
  end

  def create_mini_stars(x, y)
    mini_stars = []
    8.times do
      mini_stars << MiniStar.new(x, y, mini_stars.length * 45, @timer)
    end
    @explosions << mini_stars
  end
end

Game.run
