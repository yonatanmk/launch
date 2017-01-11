require 'hasu'
require 'pry'


class MyWindow < Hasu::Window
  GAME_SIZE = 50
  HEIGHT = GAME_SIZE * 10
  WIDTH = GAME_SIZE * 10

  def initialize
    super(WIDTH, HEIGHT)

  end

  def reset
    self.caption = 'Game of Life!'
    @green_sq = Gosu::Image.new("GreenSq.png")
    @brown_sq = Gosu::Image.new("BrownSq.png")
    @starting_grid = []
    seed_options = [0, 1]
    GAME_SIZE.times do
      seed_row = []
      GAME_SIZE.times do
        seed_row << seed_options.sample
      end
      @starting_grid << seed_row
    end
    #seed for glider
    # @starting_grid[2][2] = 1
    # @starting_grid[3][3] = 1
    # @starting_grid[4][1] = 1
    # @starting_grid[4][2] = 1
    # @starting_grid[4][3] = 1
    @frame_count = 0
  end


  def draw
    @starting_grid.each_with_index do |row, r|
      row.each_with_index do |cell, c|
        if cell == 0
          @brown_sq.draw(c*10,r*10,0)
        elsif cell == 1
          @green_sq.draw(c*10,r*10,0)
        end
      end
    end
  end

  def update
    @frame_count += 1
    return if (@frame_count % 16) != 0
      replacement_grid = []
      GAME_SIZE.times do
        replacement_grid << [0]*GAME_SIZE
      end
      @starting_grid.each_with_index do |row, r|
        row.each_with_index do |cell, c|
          live_neighbors = count_neighbors(r, c)
          if (cell == 0) && (live_neighbors == 3)
            replacement_grid[r][c] = 1
          elsif (cell == 1) && ((2..3).include? live_neighbors)
            replacement_grid[r][c] = 1
          else
            replacement_grid[r][c] = 0
          end
        end
      end
      @starting_grid = replacement_grid
  end

  def count_neighbors(row, col)
    neighbor_count = 0
    neighbor_count += @starting_grid[row-1][col-1]
    neighbor_count += @starting_grid[row-1][col]
    neighbor_count += @starting_grid[row-1][(col+1)%GAME_SIZE]
    neighbor_count += @starting_grid[row][col-1]
    neighbor_count += @starting_grid[row][(col+1)%GAME_SIZE]
    neighbor_count += @starting_grid[(row+1)%GAME_SIZE][col-1]
    neighbor_count += @starting_grid[(row+1)%GAME_SIZE][col]
    neighbor_count += @starting_grid[(row+1)%GAME_SIZE][(col+1)%GAME_SIZE]
    neighbor_count
  end

end


MyWindow.run
