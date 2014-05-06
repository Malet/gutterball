class Frame < ActiveRecord::Base
  belongs_to :game
  belongs_to :player
  has_many :rolls

  def strike?
    !!self.rolls.detect{ |r| 10 == r.pins }
  end

  def spare?
    2  == self.rolls.count &&
    10 == self.rolls.sum(:pins)
  end

  def completed?
    if self.last_frame?
      # if self.spare?
      #   false
      # else
      # if self.strike?
      #   false

    else
      self.strike? || self.rolls.size >= 2
    end
  end

  def last_frame?
    10 == self.number
  end

  def previous
    number > 1 ? game_frames[number - 1] : nil
  end

  def next
    number < 10 ? game_frames[number + 1] : nil
  end

  def number
    @frame_number ||= game_frames.index(self) + 1
  end

  def game_frames
    self.game.frames.where(player: self.player)
  end

  # def status
  #   if self.rolls == 0
  #     :roll1
  #   else
  #     # if self.rolls.first.pins == Game::PINS
  #   end
  # end
end
