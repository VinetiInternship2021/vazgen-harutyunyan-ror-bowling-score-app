class Player < ApplicationRecord
  belongs_to :session
  has_many :frames
  validates_inclusion_of :score, in: 0..300

  def current_pins_left
    if self.frames.present? && self.frames.last.turn == 1 && self.frames.last.knocked_pins != 10
      puts self.frames.last.turn
      return 10 - self.frames.last.knocked_pins 
    end

    return 10
  end

  def ended?
    unless (
      self.frames.present? &&
      (self.frames.last.frame == 10) &&
      ((self.frames.last.turn == 2 && self.frames[self.frames.count - 2].knocked_pins + self.frames[self.frames.count - 1].knocked_pins < 10) ||
      (self.frames.last.turn == 3 && self.frames[self.frames.count - 2].knocked_pins + self.frames[self.frames.count - 1].knocked_pins > 10))
  )
    return true
  end
  return false
  end

  def display
    if self.frames.present? 
      if self.frames.last.knocked_pins == 10 
        if self.frames.last.frame != 10
          frame = self.frames.last.frame + 1
          turn = 1
        elsif self.frames.last.turn < 3
            turn = self.frames.last.turn + 1
            frame = 10   
        end
      else
        if self.frames.last.turn == 2
          frame = self.frames.last.frame + 1
          turn = 1
        else
          frame = self.frames.last.frame
          turn = 2
        end
      end
      return {frame:frame,shot:turn}
    end
    return {frame:1,shot:1}
  end

  def calculated_score
    # I know nested loops are generally a bad practice, but here only 176 iterations are possible,
    # including additional shots when self strikes at last frame 
      frames_count = self.frames.length
      sum = 0
      self.frames.each_with_index do |frame,index|
        if frame.knocked_pins == 10 
          if index < frames_count - 2 && frame.turn == 1 
            #strike condition
              if self.frames[index+1].knocked_pins != 10
                sum += frame.knocked_pins + self.frames[index+1].knocked_pins + self.frames[index+2].knocked_pins
              #double condition
              else
                if self.frames[index+2].knocked_pins == 10
                  sum += 2*frame.knocked_pins + self.frames[index+2].knocked_pins
                else
                  if index < frames_count - 3
                    sum += 2*frame.knocked_pins + self.frames[index+2].knocked_pins + self.frames[index+3].knocked_pins
                  end
                end
              end
          #spare condition
          elsif index < frames_count - 1 && frame.turn == 2 
            sum += frame.knocked_pins + self.frames[index+1].knocked_pins
          else
            sum += 0
          end
        #also spare condition
        elsif index < frames_count - 1 && frame.turn == 2 && self.frames[index - 1].knocked_pins + frame.knocked_pins == 10 
            sum += 10 + self.frames[index+1].knocked_pins
        #open frame condition
        else
          if(index < frames_count - 1 && frame.turn == 1 && frame.knocked_pins + self.frames[index + 1].knocked_pins != 10) ||
            (frame.turn == 2 && frame.knocked_pins + self.frames[index - 1].knocked_pins != 10)

            sum += frame.knocked_pins
          
          end
        end
      end
    return sum
  end
  

end
