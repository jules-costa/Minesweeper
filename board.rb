require_relative 'tile'
require 'byebug'

class Board

  attr_accessor :grid

  def initialize
    @grid = Array.new(9){Array.new(9)}
  end

  def []=(pos, val)
    x, y = pos
    @grid[x][y] = val
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end


  def adjacents(pos)
    neighbors = []
    r, c = pos

        if r < @grid[0].size
          neighbors << [r+1, c]
          if c < @grid[0].size
            neighbors << [r+1, c+1]
          end
        end

        if c > 0
          neighbors << [r, c-1]
          if r < @grid[0].size
            neighbors << [r+1, c-1]
          end
        end

        if c < @grid.size
          neighbors << [r, c+1]
          if r > 0
            neighbors << [r-1, c+1]
          end
        end

        if r > 0
          neighbors << [r-1, c]
          if c > 0
            neighbors << [r-1, c-1]
          end
        end
    neighbors
  end

  def count_fringe(pos)
    neib = adjacents(pos)
    frin_n = 0
    neib.each  do |net|
     frin_n += 1 if @grid[net[0]][net[1]].bomb == true
    end
    @grid[pos[0]][pos[1]].fringe = frin_n
  end

  def populate_grid
    bomber = generate_bombs
    @grid.each_with_index do |row, r|
      row.each_with_index do |col, c|
        @grid[r][c] = Tile.new
        @grid[r][c].bomb = true if bomber.include?([r, c])
      end
    end
  end

  def show_bombs
    @grid.each  do |row|
      temp = []
      row.each  do |t|
         temp << t.bomb
      end
       p temp
    end
  end

  def generate_bombs
    bombs = []

    while bombs.size < 30
      bomb = [(0..8).to_a.sample, (0..8).to_a.sample]
      bombs << bomb unless bombs.include?(bomb)
    end

    bombs
  end

end



b = Board.new
# p b
#  p b.adjacents([0,0])
 b.populate_grid
 # p b.grid
  b.show_bomds
 p b.count_fringe([0,3])
