class Frame < ActiveRecord::Base
  belongs_to :game
  belongs_to :player
  has_many :rolls

  def strike?
    1  == self.rolls.count &&
    10 == self.rolls.first.pins
  end

  def spare?
    2  == self.rolls.count &&
    10 == self.rolls.sum(:pins)
  end

  def last_frame?
    10 == self.number
  end

  def number
    @frame_number ||= self.game.frames.where(player: self.player).index(self) + 1
  end
end
