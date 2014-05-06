class Game < ActiveRecord::Base
  has_and_belongs_to_many :players
  has_many :frames

  FRAMES_PER_GAME = 10
  PINS = 10

  def start!
    raise 'You need 1 or more players to start bowling' unless self.players.count > 0

    create_frames
  end

  def started?
    self.frames.size > 0
  end

  def roll(player, pins)
    require_game_started
    player_frame(player).rolls << Roll.create!(pins: pins)
  end

  def player_frame(player)
    require_game_started
    Frame.where(game: self, player: player).includes(:rolls).order(:id).detect{ |f| !f.completed? }
  end

  def player_score(player)
  end

private
  
  def create_frames
    self.players.each do |player|
      FRAMES_PER_GAME.times{ self.frames << Frame.create!(game: self, player: player) }
    end
  end

  def require_game_started
    raise 'You must start the game first!' unless self.started?
  end

end
