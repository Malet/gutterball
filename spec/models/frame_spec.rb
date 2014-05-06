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

private

  def rolled(pins_arr)
    pins_arr.map{ |pins| Roll.create!(pins: pins) }
  end

end
