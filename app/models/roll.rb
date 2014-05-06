class Roll < ActiveRecord::Base
  belongs_to :frame
  validates :pins, inclusion: 0..Game::PINS
end
