class Game < ActiveRecord::Base
  has_and_belongs_to_many :players
  has_many :frames

  FRAMES_PER_GAME = 10

  def start!
    raise 'You need 1 or more players to start bowling' unless self.players.count > 0

    create_frames
  end

private
  
  def create_frames
    self.players.each do |player|
      FRAMES_PER_GAME.times{ self.frames << Frame.create!(game: self, player: player) }
    end
  end

end
