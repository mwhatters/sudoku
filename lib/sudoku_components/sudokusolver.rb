require_relative 'sudokuwincheck'

class SudokuSolver
  # takes a specialized string as input
  attr_reader :board
  def initialize(board)
    @board = board
    @given_numbers = find_given_numbers
  end

  def to_int(item)
    item.split(//).map(&:to_i)
  end

  def unflatten(item)
    item.is_a?(Array) ? item.each_slice(9).to_a : to_int(item).each_slice(9).to_a
  end

  def display_board(board)
    unflatten(board).each do |row|
      puts row.join(" ")
    end
  end

  def find_given_numbers
    output = []
    to_int(board).each_with_index do |number, index|
      output << index if number > 0
    end
    output
  end

  def solve_random_board
    rand_board = (1..9).to_a.shuffle << "------------------------------------------------------------------------"
    joined = rand_board.join('')
    primed = to_int(joined)
    solve(primed)
  end

  def solve(board = to_int(@board), current_index = 0)
    cloneboard = board.dup

    sudoku_number = 1

    while @given_numbers.include?(current_index)
      current_index += 1
    end

    while sudoku_number < 10
      forward = 1
      while @given_numbers.include?(current_index + forward)
        forward += 1
      end

      system('clear')
      display_board(board)

      cloneboard[current_index] = sudoku_number
      current_board = SudokuWinChecker.new(unflatten(cloneboard))

      if current_board.valid?    # is it a valid sudoku number
        if current_board.solved? # is the board complete?
          system('clear')
          display_board(cloneboard)
          p "solved"
          return true
        end
        return true if solve(cloneboard, current_index + forward)
      end
      sudoku_number += 1
    end
    false
  end
end
