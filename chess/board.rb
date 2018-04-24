require_relative "piece"
require 'byebug'

class Board
  # attr_accessor :grid #debug
  def initialize
    @grid = Array.new(8){Array.new(8,nil)}
    set_grid 
  end 
  
  def grid_symbols
    grid_symbols = Array.new(grid.size){Array.new(grid.count,nil)}
    @grid.each_with_index do |row, y|
      row.each_with_index do |piece, x|
        grid_symbols[y][x] = piece.symbol
      end 
    end 
    grid_symbols
  end
  
  def set_grid
    null_piece = NullPiece.instance
    fresh_board = starting_positions
    fresh_board.each_with_index do |row, y|
      row.each_with_index do |piece_sym, x|
        !piece_sym.nil? ? self[[x,y]] = Piece.new(piece_sym, [x,y], self) : null_piece
      end 
    end  
  end
      
  def starting_positions 
   [[:r ,:k ,:b ,:q ,:K ,:b ,:k ,:r ],
    [:p ,:p ,:p ,:p ,:p ,:p ,:p ,:p ],
    [nil,nil,nil,nil,nil,nil,nil,nil],
    [nil,nil,nil,nil,nil,nil,nil,nil],
    [nil,nil,nil,nil,nil,nil,nil,nil],
    [nil,nil,nil,nil,nil,nil,nil,nil],
    [:p ,:p ,:p ,:p ,:p ,:p ,:p ,:p ],
    [:r ,:k ,:b ,:K,:q ,:b ,:k ,:r ]]
  end 
  
  def move_piece(start_pos, end_pos)
    #update grid and also piece's position
    piece1 = self[start_pos]
    piece2 = self[end_pos]
    #raise 'no piece at position 1' if piece1.is_a? NilPiece 
    self[start_pos], self[end_pos] = piece2, piece1
    # piece1.pos = end_pos
    # piece2.pos = start_pos 
  end 
  
  private
  attr_accessor :grid 
  def [](pos)
    x,y = pos  
    @grid[y][x]
  end 
  
  def []=(pos,value)
    x,y = pos
    #debugger
    @grid[y][x] = value
  end
  
  
end