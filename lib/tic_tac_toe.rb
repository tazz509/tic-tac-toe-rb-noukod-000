def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player == "X")
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index)
    display_board(board)
  else
    turn(board)
  end
end

# Define your play method below
def play(board)
  counter = 0

 while counter < 9
    turn(board)
    counter += 1
  end
end

def turn_count(board)
  counter = 0

  board.each do |choix|
    counter += choix == "X" || choix == "O"? 1 : 0
  end
 return counter
end

def current_player(board)
  player = turn_count(board)%2 == 0? "X" : "O"
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
[0, 1, 2],
[3, 4, 5],
[6, 7, 8],
[0, 4, 8],
[1, 4, 7],
[0, 3, 6],
[2, 5, 8],
[2, 4, 6]
]


def won?(board)

  WIN_COMBINATIONS.each do |win_combination|
        win_index_1 = win_combination[0]
        win_index_2 = win_combination[1]
        win_index_3 = win_combination[2]

        position_1 = board[win_index_1] # load the value of the board at win_index_1
        position_2 = board[win_index_2] # load the value of the board at win_index_2
        position_3 = board[win_index_3] # load the value of the board at win_index_3

        if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
           return win_combination # return the win_combination indexes that won.
        end
  end
  return false
end

def full?(board)
  board.all? {|position| position == "X" or position == "O"}
end

def  draw?(board)
  if won?(board) != false   # return false for in-progress game
    return false
  else
    return true
  end
end

 def over?(board)
   if draw?(board) == true    #if draw is true tes if there's empty index
     return !board.any? {|index| index == " "}
   end
   if draw?(board) == true or won?(board) != false
     return true
   end
 end

def winner(board)
  array = won?(board)
  if array != false
    if board[array[0]] == "X"
      return "X"
    else
      return "O"
    end
  end
end
