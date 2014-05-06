require 'spec_helper'

describe Game do
  describe 'validations' do
    it{ should have_many(:frames) }
    it{ should have_and_belong_to_many(:players) }
  end

  describe '#start!' do
    let(:game){ Game.create!(players: players) }
    subject{ game.start! }
    
    context 'has no players' do
      let(:players){ [] }
      it{ expect{ subject }.to raise_error(RuntimeError, "You need 1 or more players to start bowling") }
    end

    context 'has 1 player' do
      let(:players){ [create(:alice)] }
      it 'should create 10 frames for 1 player' do
        subject
        expect(Frame.where(game: game).count).to eq(10)
      end
    end

    context 'has 2 players' do
      let(:players){ [create(:alice), create(:bob)] }
      it 'should create 20 frames for 2 players' do
        subject
        expect(Frame.where(game: game).count).to eq(20)
      end
    end
  end

  describe '#roll' do
    let(:game){ Game.create!(players: players) }
    subject{ game.roll(player, pins) }
    before{ game.start! }

    context '1 player game' do
      let(:players){ [create(:alice)] }
      let(:player){ players.first }
      let(:pins){ 4 }

      it 'should increment the amount of rolls when a player rolls' do
        expect{ subject }.
        to change{
          Roll.joins(:frame).
          where('frames.player_id = ?', player.id).
          where('frames.game_id   = ?', game.id).count
        }.
        by(+1)
      end
    end
  end

end
