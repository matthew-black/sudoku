require_relative '../sudoku'

describe "Sudoku" do
  solvable = "1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--"
  unsolvable = "--7--8------2---6-65--79----7----3-5-83---67-2-1----8----71--38-2---5------4--2--"

let (:solvable_board) { create_board(solvable) }
let (:unsolvable_board) { create_board(unsolvable) }

let (:solved_board) { solve(create_board(solvable)) }
let (:unsolved_board) { solve(create_board(unsolvable)) }

coordinate_board = [
  [["Row 0, Column 0"], ["Row 0, Column 1"], ["Row 0, Column 2"], ["Row 0, Column 3"], ["Row 0, Column 4"], ["Row 0, Column 5"], ["Row 0, Column 6"], ["Row 0, Column 7"], ["Row 0, Column 8"]], # row0

  [["Row 1, Column 0"], ["Row 1, Column 1"], ["Row 1, Column 2"], ["Row 1, Column 3"], ["Row 1, Column 4"], ["Row 1, Column 5"], ["Row 1, Column 6"], ["Row 1, Column 7"], ["Row 1, Column 8"]], #row1

  [["Row 2, Column 0"], ["Row 2, Column 1"], ["Row 2, Column 2"], ["Row 2, Column 3"], ["Row 2, Column 4"], ["Row 2, Column 5"], ["Row 2, Column 6"], ["Row 2, Column 7"], ["Row 2, Column 8"]], #row2

  [["Row 3, Column 0"], ["Row 3, Column 1"], ["Row 3, Column 2"], ["Row 3, Column 3"], ["Row 3, Column 4"], ["Row 3, Column 5"], ["Row 3, Column 6"], ["Row 3, Column 7"], ["Row 3, Column 8"]], #row3

  [["Row 4, Column 0"], ["Row 4, Column 1"], ["Row 4, Column 2"], ["Row 4, Column 3"], ["Row 4, Column 4"], ["Row 4, Column 5"], ["Row 4, Column 6"], ["Row 4, Column 7"], ["Row 4, Column 8"]], #row4

  [["Row 5, Column 0"], ["Row 5, Column 1"], ["Row 5, Column 2"], ["Row 5, Column 3"], ["Row 5, Column 4"], ["Row 5, Column 5"], ["Row 5, Column 6"], ["Row 5, Column 7"], ["Row 5, Column 8"]], #row5

  [["Row 6, Column 0"], ["Row 6, Column 1"], ["Row 6, Column 2"], ["Row 6, Column 3"], ["Row 6, Column 4"], ["Row 6, Column 5"], ["Row 6, Column 6"], ["Row 6, Column 7"], ["Row 6, Column 8"]], #row6

  [["Row 7, Column 0"], ["Row 7, Column 1"], ["Row 7, Column 2"], ["Row 7, Column 3"], ["Row 7, Column 4"], ["Row 7, Column 5"], ["Row 7, Column 6"], ["Row 7, Column 7"], ["Row 7, Column 8"]], #row7

  [["Row 8, Column 0"], ["Row 8, Column 1"], ["Row 8, Column 2"], ["Row 8, Column 3"], ["Row 8, Column 4"], ["Row 8, Column 5"], ["Row 8, Column 6"], ["Row 8, Column 7"], ["Row 8, Column 8"]] #row8
]

  describe '#create_board' do
    it 'updates the value of solved cell at 0,0' do
      expect(solvable_board[0][0]).to eq [1]
    end

    it 'updates the value of solved cell at 8,6' do
      expect(solvable_board[8][6]).to eq [9]
    end
  end

  describe '#row' do
    it 'returns the 4th row' do
      expect(row(coordinate_board, 4)).to eq [["Row 4, Column 0"], ["Row 4, Column 1"], ["Row 4, Column 2"], ["Row 4, Column 3"], ["Row 4, Column 4"], ["Row 4, Column 5"], ["Row 4, Column 6"], ["Row 4, Column 7"], ["Row 4, Column 8"]]
    end

    it 'returns the 7th row' do
      expect(row(coordinate_board, 7)).to eq [["Row 7, Column 0"], ["Row 7, Column 1"], ["Row 7, Column 2"], ["Row 7, Column 3"], ["Row 7, Column 4"], ["Row 7, Column 5"], ["Row 7, Column 6"], ["Row 7, Column 7"], ["Row 7, Column 8"]]
    end
  end

  describe '#column' do
    it 'returns the 4th column' do
      expect(column(coordinate_board, 4)).to eq [["Row 0, Column 4"], ["Row 1, Column 4"], ["Row 2, Column 4"], ["Row 3, Column 4"], ["Row 4, Column 4"], ["Row 5, Column 4"], ["Row 6, Column 4"], ["Row 7, Column 4"], ["Row 8, Column 4"]]
    end

    it 'returns the 9th column' do
      expect(column(coordinate_board, 8)).to eq [["Row 0, Column 8"], ["Row 1, Column 8"], ["Row 2, Column 8"], ["Row 3, Column 8"], ["Row 4, Column 8"], ["Row 5, Column 8"], ["Row 6, Column 8"], ["Row 7, Column 8"], ["Row 8, Column 8"]]
    end

    it 'does not destructively modify the board' do
      expect(coordinate_board[8]).to eq [["Row 8, Column 0"], ["Row 8, Column 1"], ["Row 8, Column 2"], ["Row 8, Column 3"], ["Row 8, Column 4"], ["Row 8, Column 5"], ["Row 8, Column 6"], ["Row 8, Column 7"], ["Row 8, Column 8"]]
      expect(column(coordinate_board, 8)).to eq [["Row 0, Column 8"], ["Row 1, Column 8"], ["Row 2, Column 8"], ["Row 3, Column 8"], ["Row 4, Column 8"], ["Row 5, Column 8"], ["Row 6, Column 8"], ["Row 7, Column 8"], ["Row 8, Column 8"]]
      expect(coordinate_board[8]).to eq [["Row 8, Column 0"], ["Row 8, Column 1"], ["Row 8, Column 2"], ["Row 8, Column 3"], ["Row 8, Column 4"], ["Row 8, Column 5"], ["Row 8, Column 6"], ["Row 8, Column 7"], ["Row 8, Column 8"]]
    end
  end

  describe '#find_box' do
    it "assigns a box number based on the current cell's coordinates" do
      expect(find_box(0,0)).to eq 0
      expect(find_box(0, 3)).to eq 1
      expect(find_box(3,3)).to eq 4
      expect(find_box(8,8)).to eq 8
    end
  end

  describe '#box' do
    it 'returns box 0' do
      expect(box(coordinate_board, 0)).to eq [["Row 0, Column 0"], ["Row 0, Column 1"], ["Row 0, Column 2"], ["Row 1, Column 0"], ["Row 1, Column 1"], ["Row 1, Column 2"], ["Row 2, Column 0"], ["Row 2, Column 1"], ["Row 2, Column 2"]]
    end

    it 'returns box 4' do
      expect(box(coordinate_board, 4)).to eq [["Row 3, Column 3"], ["Row 3, Column 4"], ["Row 3, Column 5"], ["Row 4, Column 3"], ["Row 4, Column 4"], ["Row 4, Column 5"], ["Row 5, Column 3"], ["Row 5, Column 4"], ["Row 5, Column 5"]]
    end

    it 'returns box 8' do
      expect(box(coordinate_board, 8)).to eq [["Row 6, Column 6"], ["Row 6, Column 7"], ["Row 6, Column 8"], ["Row 7, Column 6"], ["Row 7, Column 7"], ["Row 7, Column 8"], ["Row 8, Column 6"], ["Row 8, Column 7"], ["Row 8, Column 8"]]
    end
  end

  describe "#solve" do
    it 'returns a solved puzzle if it is able' do
      solved = solve(solvable_board)
      expect(solved).to eq solved_board
    end

    it "returns the current state of the board if it can't solve the puzzle" do
      unsolved = solve(unsolvable_board)
      expect(unsolved).to eq unsolved_board
    end
  end

  describe '#solved' do
    it 'returns false if the puzzle is not solved' do
      expect(solved?(unsolvable_board)).to eq false
    end

    it 'returns true if the puzzle is solved' do
      expect(solved?(solved_board)).to eq true
    end
  end

  describe '#pretty_board' do
    it 'returns an array that contains symmetric strings for a solved puzzle' do
      success = pretty_board(solved_board)
      expect(success).to be_a(Array)
      expect(success.all?{|row| row.length == 17})
    end

    it 'returns an array that contains symmetric strings for an unsolved puzzle' do
      nope = pretty_board(unsolved_board)
      expect(nope).to be_a(Array)
      expect(nope.all?{|row| row.length == 17})
    end

    it 'truly does make the board look very pretty' do
      "This test is pure nonsense and everyobody knows it."
    end
  end

  describe '#sherlock_the_row' do
    it 'uses row info to solve cells that earlier logic could not' do
      "Write tests!"
    end
  end

  describe '#sherlock_the_column' do
    it 'uses column info to solve cells that earlier logic could not' do
      "Write the tests!"
    end
  end

  describe '#sherlock_the_box' do
    it 'uses box info to solve cells that earlier logic could not' do
      "Write ALL the tests!"
    end
  end

end











