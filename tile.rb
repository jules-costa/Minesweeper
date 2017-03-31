class Tile
  attr_accessor :flag, :bomb, :display, :fringe, :neighbors

  def initialize
    @flag = false
    @bomb = false
    @display = false
    @fringe = 0
    @neighbors = []
  end

end
