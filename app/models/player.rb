class Player < ActiveRecord::Base
  has_and_belongs_to_many :games
  has_many :frames
  validates_presence_of :name
end
