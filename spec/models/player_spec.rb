require 'spec_helper'

describe Player do
  describe 'validations' do
    it{ should have_and_belong_to_many(:games) }
    it{ should have_many(:frames) }
    it{ should validate_presence_of(:name) }
  end
end
