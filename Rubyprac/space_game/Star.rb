class Star
  attr_reader :x, :y

  def initialize
    @x = rand(20..620)
    @y = rand(20..460)
    @image = Gosu::Image.new("./star_2.png")
    # @star_anim = Gosu::Image::load_tiles("./star_anim.png", 25, 25)
    @angle = 0

    @color = Gosu::Color.new(0xff_000000)
    @color.red = rand(256 - 40) + 40
    @color.green = rand(256 - 40) + 40
    @color.blue = rand(256 - 40) + 40
  end

  def draw
    @angle += 1
    @image.draw_rot(@x, @y, 1, @angle, center_x = 0.5, center_y = 0.5, scale_x = 0.5, scale_y = 0.5, @color)
    # img = @star_anim[Gosu::milliseconds / 100 % @star_anim.size];
    # img.draw(@x - img.width / 2.0, @y - img.height / 2.0, 1, 1, 1, @color, :add)
  end

end
