require "test/unit"

class MineSweeperTests < Test::Unit::TestCase
  def test_empty_minefield
    minesweeper = MineSweeper.new 0, 0
    output = minesweeper.display
    assert_equal("", output)
  end

  def test_one_by_one_minefield_with_no_mines
    minesweeper = MineSweeper.new 1, 1
    output = minesweeper.display
    assert_equal("0", output)
  end

  def test_two_by_one_minefield_with_no_mines
    minesweeper = MineSweeper.new 2, 1
    output = minesweeper.display
    assert_equal("0\n0", output)
  end

  def test_one_by_one_minefield_with_one_mine
    minesweeper = MineSweeper.new 1, 1
    minesweeper.add_mine 1,1
    output = minesweeper.display
    assert_equal("*", output)
  end

  def test_two_by_two_minefield_with_one_mine
    minesweeper = MineSweeper.new 2, 2
    minesweeper.add_mine 1,1
    output = minesweeper.display
    assert_equal("*1\n11", output)
  end

  def test_two_by_two_minefield_with_two_mines
    minesweeper = MineSweeper.new 2, 2
    minesweeper.add_mine 1,1
    minesweeper.add_mine 2,2
    output = minesweeper.display
    assert_equal("*2\n2*", output)
  end

  def test_four_by_five_minefield_with_four_mines
    minesweeper = MineSweeper.new 4, 5
    minesweeper.add_mine 1,1
    minesweeper.add_mine 2,5
    minesweeper.add_mine 3,3
    minesweeper.add_mine 4,2
    output = minesweeper.display
    assert_equal("*1011\n1212*\n12*21\n1*210", output)
  end
end

class MineSweeper
  def initialize rows, columns
    @rows = rows
    @columns = columns
    @mines = []
  end

  def display
    output = ""
    row_index = 0
    while row_index < @rows do
      column_index = 0
      while column_index < @columns do
	output << get_hint(row_index, column_index)
	column_index += 1
      end
      output << "\n"
      row_index += 1
    end
    output.chomp!
    output
  end

  def add_mine row, column
    @mines << "#{row-1},#{column-1}"
  end
  
  private
  def get_hint row_index, column_index
    if @mines.include?("#{row_index},#{column_index}")
      "*"
    else
      count_mine_neighbours row_index, column_index
    end
  end

  def count_mine_neighbours row_index, column_index
    mine_neighbours = 0
    [row_index-1,row_index,row_index+1].each do |row|
      [column_index-1,column_index,column_index+1].each do |column|
        if (row != row_index or column != column_index) and @mines.include?("#{row},#{column}")
	  mine_neighbours += 1
	end
      end
    end
    mine_neighbours.to_s
  end
end
