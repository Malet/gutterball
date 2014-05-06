require 'spec_helper'

describe Frame do
  describe 'validations' do
    it{ should belong_to(:game) }
    it{ should have_many(:rolls) }
  end

  describe '#strike?' do
    subject{ frame.strike? }
    let(:frame){ Frame.create!(rolls: rolls) }
    
    context 'strike' do
      let(:rolls){ rolled [10] }
      it{ should == true }
    end
    
    context 'spare' do
      let(:rolls){ rolled [5,5] }
      it{ should == false }
    end

    context 'nothing has occurred' do
      context 'no rolls' do
        let(:rolls){ [] }
        it{ should == false }
      end

      context 'no spares or strikes' do
        let(:rolls){ rolled [2,3] }
        it{ should == false }
      end

      context 'gutterballs' do
        let(:rolls){ rolled [0,0] }
        it{ should == false }
      end
    end
  end

  describe '#spare?' do
    subject{ frame.spare? }
    let(:frame){ Frame.create!(rolls: rolls) }
    
    context 'strike' do
      let(:rolls){ rolled [10] }
      it{ should == false }
    end
    
    context 'spare' do
      let(:rolls){ rolled [5,5] }
      it{ should == true }
    end

    context 'nothing has occurred' do
      context 'no rolls' do
        let(:rolls){ [] }
        it{ should == false }
      end

      context 'no spares or strikes' do
        let(:rolls){ rolled [2,3] }
        it{ should == false }
      end

      context 'gutterballs' do
        let(:rolls){ rolled [0,0] }
        it{ should == false }
      end
    end
  end

  describe '#number' do
    let(:game){ Game.create!(players: players) }
    
    before{ game.start! }

    context 'a single player game' do
      let(:players){ [create(:alice)] }

      specify 'frame#number is equal to it\'s (index+1) in Game#frames' do
        game.frames.each_with_index do |frame,index|
          expect(frame.number).to eq(index + 1)
        end
      end
    end

    context 'a two player game' do
      let(:players){ [create(:alice), create(:bob)] }

      specify 'frame#number is equal to it\'s (index+1) in Game#frames' do
        game.frames.where(player: players.first).each_with_index do |frame,index|
          expect(frame.number).to eq(index + 1)
        end
        game.frames.where(player: players.last).each_with_index do |frame,index|
          expect(frame.number).to eq(index + 1)
        end
      end
    end
  end

  describe '#last_frame?' do
    let(:game){ Game.create!(players: players) }
    
    before{ game.start! }

    context 'a single player game' do
      let(:players){ [create(:alice)] }

      specify 'returns true if it is the last frame, false otherwise' do
        expected = 9.times.map{false} + [true]
        game.frames.each_with_index do |frame, index|
          expect(frame.last_frame?).to be(expected[index])
        end
      end
    end

    context 'a two player game' do
      let(:players){ [create(:alice), create(:bob)] }

      specify 'returns true if it is the last frame, false otherwise' do
        expected = 9.times.map{false} + [true]
        game.frames.where(player: players.first).each_with_index do |frame, index|
          expect(frame.last_frame?).
          to be(expected[index])
        end
        game.frames.where(player: players.last).each_with_index do |frame, index|
          expect(frame.last_frame?).
          to be(expected[index])
        end
      end
    end
  end

private

  def rolled(pins_arr)
    pins_arr.map{ |pins| Roll.create!(pins: pins) }
  end

end
