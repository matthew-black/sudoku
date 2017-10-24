# The #sherlock methods are screaming out for method extraction.
# They're nearly identical, which is not cool if you want to
# eventually show this off on some kind of portfolio site.

##--- Looping Method that Runs Until Success or Failure ---##
def solve(board)
  puzzle_iterations = 0
  out_of_solving_logic = false
  until out_of_solving_logic
    row = 0

    while row < 9
      index = 0
      while index < 9
        if board[row][index].length > 1
          remove_illogical_values(board, row, index)
          attempt_deductive_solution(board, row, index)
        end
        index += 1
      end
      row += 1
    end

    if puzzle_iterations == 0
      board_state = board.flatten
    else
      out_of_solving_logic = board_state == board.flatten
      board_state = board.flatten
    end

  puzzle_iterations += 1
  end
  board
end

##--- Methods that Return Specific Parts of the Board ---##
  # returns entire row as an array
def get_row(board, row)
  board[row]
end

  # returns entire column as an array
def get_column(board, index)
  board.transpose[index]
end

  # returns entire box as an array
def get_box(board, box_number)
  case box_number
    when 0
      board[0][0..2] + board[1][0..2] + board[2][0..2]
    when 1
      board[0][3..5] + board[1][3..5] + board[2][3..5]
    when 2
      board[0][6..8] + board[1][6..8] + board[2][6..8]
    when 3
      board[3][0..2] + board[4][0..2] + board[5][0..2]
    when 4
      board[3][3..5] + board[4][3..5] + board[5][3..5]
    when 5
      board[3][6..8] + board[4][6..8] + board[5][6..8]
    when 6
      board[6][0..2] + board[7][0..2] + board[8][0..2]
    when 7
      board[6][3..5] + board[7][3..5] + board[8][3..5]
    when 8
      board[6][6..8] + board[7][6..8] + board[8][6..8]
  end
end

  # helper method for #box
def find_box(row, index)
  if [0, 1, 2].include?(row) && [0, 1, 2].include?(index)
    return 0
  elsif [0, 1, 2].include?(row) && [3, 4, 5].include?(index)
    return 1
  elsif [0, 1, 2].include?(row) && [6, 7, 8].include?(index)
    return 2
  elsif [3, 4, 5].include?(row) && [0, 1, 2].include?(index)
    return 3
  elsif [3, 4, 5].include?(row) && [3, 4, 5].include?(index)
    return 4
  elsif [3, 4, 5].include?(row) && [6, 7, 8].include?(index)
    return 5
  elsif [6, 7, 8].include?(row) && [0, 1, 2].include?(index)
    return 6
  elsif [6, 7, 8].include?(row) && [3, 4, 5].include?(index)
    return 7
  else
    return 8
  end
end

##--- Initial Logic: Solves the First 5 Puzzles ---##
  # deletes integers from cell's array based on other solved cells
def remove_illogical_values(board, row, index)
  solved = find_solved_cells(board, row, index)
  board[row][index].delete_if do |num|
    solved.include?(num)
  end
end

  # returns relevant instances of solved cells
def find_solved_cells(board, row, index)
  solved = []
  current_box = find_box(row, index)
  solved << get_row(board, row).select { |cell| cell.length == 1 }
  solved << get_column(board, index).select { |cell| cell.length == 1 }
  solved << get_box(board, current_box).select { |cell| cell.length == 1 }
  solved.flatten.uniq
end

##--- Additional Logic: Solves Puzzles 6-10 ---##
  # applies deductive logic based on row, column, and box
def attempt_deductive_solution(board, row, index)
  sherlock_the_row(board, row, index)
  sherlock_the_column(board, row, index)
  sherlock_the_box(board, row, index)
end

  # uses deductive logic on all possible values in the cell's row
def sherlock_the_row(board, row, index)
  if board[row][index].length > 1
    row_possibles = get_row(board, row).reject.with_index do |cell, i|
      i == index
    end
    sherlocked = [1,2,3,4,5,6,7,8,9] - row_possibles.flatten.uniq
    if sherlocked.length == 1
      board[row][index] = sherlocked
    end
  end
end

    # uses deductive logic on all possible values in the cell's column
def sherlock_the_column(board, row, index)
  if board[row][index].length > 1
    column_possibles = get_column(board, index).reject.with_index do |cell, r|
      r == row
    end
    sherlocked = [1,2,3,4,5,6,7,8,9] - column_possibles.flatten.uniq
    if sherlocked.length == 1
      board[row][index] = sherlocked
    end
  end
end

    # uses deductive logic on all possible values in the cell's box
def sherlock_the_box(board, row, index)
  if board[row][index].length > 1
    current_box = find_box(row, index)
    box_possibles = get_box(board, current_box).reject do |cell|
      cell == board[row][index]
    end
    if box_possibles.length == 8 # any way to get around this hack-y solution?
      sherlocked = [1,2,3,4,5,6,7,8,9] - box_possibles.flatten.uniq
      if sherlocked.length == 1
        board[row][index] = sherlocked
      end
    end
  end
end


#-- Other Uninteresting but Necessary Methods --#
  # returns true if puzzle is solved, false if not
def solved?(board)
  board.all? { |row| row.flatten.length == 9 }
end

  # formats end-state output for terminal
def pretty_board(board)
  if board.all? {|row| row.flatten.length == 9}
    board.map {|row| row.join(' ')}
  else
    fail_board = board.map do |row|
      row.map do |cell|
        if cell.length > 1
          cell = ['*']
        else
          cell
        end
      end
    end
    fail_board.map {|row| row.join(' ')}
  end
end

  # creates intial board state using a puzzle string
def create_board(puzzle_string)
  board = Array.new(9) { Array.new(9) { [1,2,3,4,5,6,7,8,9] } }
  row = 0
  index = 0
  string_counter = 0
  while row < 9
    index = 0
    while index < 9
      if puzzle_string[string_counter] != "-"
        board[row][index] = [puzzle_string[string_counter].to_i]
      end
      index += 1
      string_counter +=1
    end
    row += 1
  end
  board
end