class Frame < ActiveRecord::Base
  belongs_to :game
  belongs_to :player
  has_many :rolls
end
