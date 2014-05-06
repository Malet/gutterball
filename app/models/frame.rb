class Frame < ActiveRecord::Base
  belongs_to :game
  belongs_to :player
  has_many :rolls

  def strike?
    1  == self.rolls.count &&
    10 == self.rolls.first.pins
  end
end
