require 'pry'
# This should take in an array of rolls and return an array of scores for each individual frame that was given
# [4,  5,  "X",  8]  should  return  [9,  nil,  nil]
# When  the  second  roll  of  the  third  frame  comes  in,  all  three  frames 
# should be returned, e.g. [4, 5, "X", 8, 1] would return [9, 19,  9]
module Calculator
  :available
  PIN_VALUES = {
    0 => 0,
    1 => 1,
    2 => 2,
    3 => 3,
    4 => 4,
    5 => 5,
    6 => 6,
    7 => 7,
    8 => 8,
    9 => 9,
    "/" => 10,
    "X" => 10 }.freeze

  # First write the actual calculator part
  def calculate_frame_scores(rolls)
    raise ArgumentError, 'Invalid data' unless rolls.is_a?(Array) && rolls.all? { |value| PIN_VALUES.keys.include?(value) }
    
    frame_scores = []
    remaining_rolls = rolls.dup
    return [nil] if rolls.size < 2 # frame score can't be calculated yet regardless of what is rolled
    until remaining_rolls.size == 0
      roll_1 = remaining_rolls[0]
      roll_2 = remaining_rolls[1]
      roll_3 = remaining_rolls[2]

      last_frame = frame_scores.size == 9
      
      if is_a_strike?(roll_1)
        score = PIN_VALUES[roll_1]
        # remove the strike fron the list, but keep further ones
        last_frame ? remaining_rolls.shift(3) : remaining_rolls.shift
        if [roll_2, roll_3].include?(nil)
          frame_scores << nil
        elsif is_a_spare?(roll_3)
          frame_scores << score += PIN_VALUES[roll_3]
        elsif is_a_strike?(roll_2)
          frame_scores << score += PIN_VALUES[roll_2] + PIN_VALUES[roll_3]
        end
      elsif is_a_spare?(roll_2)
        last_frame ? remaining_rolls.shift(3) : remaining_rolls.shift(2)
        if roll_3.nil?
          frame_scores << nil
        else
          frame_scores << PIN_VALUES[roll_2] + PIN_VALUES[roll_3]
        end
      else
        remaining_rolls.shift
        if roll_2.nil?
          frame_scores << nil 
        else
          # if the first 2 rolls in the 10th frame are numerical, they don't get a third
          remaining_rolls.shift
          frame_scores << PIN_VALUES[roll_1] + PIN_VALUES[roll_2]
        end
      end
    end
    frame_scores
  end

  def is_a_strike?(roll)
    roll.is_a?(String) && roll.upcase == "X"
  end

  def is_a_spare?(roll)
    roll.is_a?(String) && roll == "/"
  end
end
