require 'spec_helper'

describe Game do
  describe 'validations' do
    it{ should have_many(:frames) }
    it{ should have_and_belong_to_many(:players) }
  end
end
