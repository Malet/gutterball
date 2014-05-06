class Roll < ActiveRecord::Base
  belongs_to :frame
  validates :pins, inclusion: 0..Game::PINS

  def strike?
    (Game::PINS == self.pins) && !self.split?
  end

  def split?
    self.number == 2 &&
    ((frame_rolls[0] + frame_rolls[1]) == Game::PINS)
  end

  def number
    @roll_number ||= frame_rolls.index(self) + 1
  end

private

  def frame_rolls
    self.frame.rolls
  end

end
