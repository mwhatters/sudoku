require_relative '../graphutils/graphutils'

class SudokuWinChecker
# Expects to be initialized with a two-d array
  include GraphUtils
  def initialize(board)
    @board = board
  end

  def solved?
    solved_unit(squares) && solved_unit(@board) && solved_unit(columns)
  end

  def valid?
    valid_unit(squares) && valid_unit(@board) && valid_unit(columns)
  end

  private
  def squares
    [
      #Upper boxes
      GraphUtils.surrounding_coordinates_to_values(@board, [1,1]),
      GraphUtils.surrounding_coordinates_to_values(@board, [1,4]),
      GraphUtils.surrounding_coordinates_to_values(@board, [1,7]),
      #Middle Boxes
      GraphUtils.surrounding_coordinates_to_values(@board, [4,1]),
      GraphUtils.surrounding_coordinates_to_values(@board, [4,4]),
      GraphUtils.surrounding_coordinates_to_values(@board, [4,7]),
      #Bottom Boxes
      GraphUtils.surrounding_coordinates_to_values(@board, [7,1]),
      GraphUtils.surrounding_coordinates_to_values(@board, [7,4]),
      GraphUtils.surrounding_coordinates_to_values(@board, [7,7])
    ]
  end

  def columns
    (0..8).each_with_object([]) {|column, container| container << GraphUtils.find_column(@board, column)}
  end

  def solved_unit(items)
    items.each do |item|
      return false unless item.reduce(:+) == 45
      return false unless item.uniq == item
    end
    true
  end

  def valid_unit(items)
    # A row/square/row is valid if the same number doesn't repeat twice
    items.each do |item|
      duped = item.dup
      duped.delete(0)
      return false unless duped.uniq == duped
    end
    true
  end

end