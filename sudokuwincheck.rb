require_relative 'graphutils'
require_relative 'sudokusolver'

class SudokuWinChecker
# Expects to be initialized with a two-d array
  include GraphUtils
  def initialize(board)
    @board = board
  end

  def solved?
    return false unless solved_unit(squares)
    return false unless solved_unit(@board)
    return false unless solved_unit(columns)
    return true
  end

  def valid?
    return false unless valid_unit(squares.dup)
    return false unless valid_unit(@board.dup)
    return false unless valid_unit(columns.dup)
    return true
  end

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
    [
      GraphUtils.find_column(@board, 0),
      GraphUtils.find_column(@board, 1),
      GraphUtils.find_column(@board, 2),
      GraphUtils.find_column(@board, 3),
      GraphUtils.find_column(@board, 4),
      GraphUtils.find_column(@board, 5),
      GraphUtils.find_column(@board, 6),
      GraphUtils.find_column(@board, 7),
      GraphUtils.find_column(@board, 8)
    ]
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


testboard = [
  [1,2,3,4,5,6,7,8,9],
  [1,2,3,4,5,6,7,8,9],
  [1,2,3,4,5,6,7,8,9],
  [1,2,3,4,5,6,7,8,9],
  [1,2,3,4,5,6,7,8,9],
  [1,2,3,4,5,6,7,8,9],
  [1,2,3,4,5,6,7,8,9],
  [1,2,3,4,5,6,7,8,9],
  [1,2,3,4,5,6,7,8,9]
]

valid_board = [
  [1,0,0,0,0,0,0,0,0],
  [2,0,0,0,0,0,0,0,3],
  [3,0,0,0,0,0,0,2,0],
  [0,3,0,0,0,0,2,0,0],
  [5,0,0,6,0,0,0,0,0],
  [0,0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0,0],
  [0,0,4,0,0,2,0,0,0],
  [0,0,0,0,0,0,0,0,0]
]

invalid_board = [
  [1,0,0,0,0,0,0,0,0],
  [2,0,0,0,0,0,0,0,3],
  [3,0,0,0,0,0,0,2,0],
  [0,3,0,0,0,0,2,0,0],
  [5,0,0,6,0,0,0,0,0],
  [0,0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0,0],
  [0,0,4,0,0,2,0,0,2],
  [0,0,0,0,0,0,0,0,0]
]

empty_board = [
  [0,0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0,0]
]

solved =[ [1,2,3,4,5,6,7,8,9],
          [4,5,6,7,8,9,1,2,3],
          [7,8,9,1,2,3,4,5,6],
          [2,1,4,3,6,5,8,9,7],
          [3,6,5,8,9,7,2,1,4],
          [8,9,7,2,1,4,3,6,5],
          [5,3,1,6,4,2,9,7,8],
          [6,4,2,9,7,8,5,3,1],
          [9,7,8,5,3,1,6,4,2] ]