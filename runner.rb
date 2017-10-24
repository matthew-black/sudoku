require_relative 'sudoku'

puzzle_number = ARGV[0].to_i
puzzle_string = File.readlines('sudoku_puzzles.txt')[puzzle_number - 1].chomp
solved_board = solve(create_board(puzzle_string))

if solved?(solved_board)
  puts "This computer has sick sudoku skills!\nCheck it out:"
  puts pretty_board(solved_board)
  puts " -- Puzzle ##{puzzle_number} --"
else
  puts "This program must really suck.\nWho even wrote this crap?\nFail:"
  puts pretty_board(solved_board)
  puts " -- Puzzle ##{puzzle_number} --"
end
