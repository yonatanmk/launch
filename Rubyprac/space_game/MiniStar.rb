class MiniStar
  attr_reader :birthday

  def initialize(x, y, trajectory, birthday)
    @x = x
    @y = y
    @trajectory = trajectory
    @birthday = birthday
    @image = Gosu::Image.new("./star_2.png")
    @angle = 0

    @color = Gosu::Color.new(0xff_000000)
    @color.red = rand(256 - 40) + 40
    @color.green = rand(256 - 40) + 40
    @color.blue = rand(256 - 40) + 40
  end

  def move
    @x -= Gosu::offset_x(@trajectory, 2)
    @y -= Gosu::offset_y(@trajectory, 2)
  end

  def draw
    @angle += 10
    @image.draw_rot(@x, @y, 1, @angle, center_x = 0.5, center_y = 0.5, scale_x = 0.1, scale_y = 0.1, @color)
  end

end
