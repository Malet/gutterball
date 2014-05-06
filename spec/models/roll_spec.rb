require 'spec_helper'

describe Roll do
  describe 'validations' do
    it{ should belong_to(:frame) }
    it{ should ensure_inclusion_of(:pins).in_range(0..Game::PINS) }
  end

  describe '#strike' do
    context 'strike is scored' do
      subject{ roll.strike? }
      let(:roll){ create(:roll, pins: Game::PINS) }
      it{ should == true }
    end

    context 'strike is not scored' do
      specify do
        (0..(Game::PINS-1)).each do |pins|
          expect(create(:roll, pins: pins).strike?).to be(false)
        end
      end
    end
  end

  describe '#number' do
    let(:frame){ create(:frame) }
    
    specify 'roll#number is equal to it\'s (index+1) in Frame#rolls' do
      frame.rolls.each_with_index do |roll,index|
        expect(roll.number).to eq(index + 1)
      end
    end
  end

end
