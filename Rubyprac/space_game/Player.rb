class Player
  attr_reader :x, :y, :score

  def initialize
    @image = Gosu::Image.new("./starfighter.bmp")
    @x = 320
    @y = 240
    @vel_x = @vel_y = @angle = @rot_vel = 0.0
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def turn_left
    @rot_vel -= 0.3
  end

  def turn_right
    @rot_vel += 0.3
  end

  def accelerate
    @vel_x += Gosu::offset_x(@angle, 0.5)
    @vel_y += Gosu::offset_y(@angle, 0.5)
  end

  def decelerate
    @vel_x -= Gosu::offset_x(@angle, 0.5)
    @vel_y -= Gosu::offset_y(@angle, 0.5)
  end

  def move
    @x += @vel_x
    @y += @vel_y
    @x %= 640
    @y %= 480

    @angle += @rot_vel

    @rot_vel *= 0.95

    @vel_x *= 0.95
    @vel_y *= 0.95
  end

  def draw
    @image.draw_rot(@x, @y, 3, @angle)
  end
end
