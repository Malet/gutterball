require 'spec_helper'

describe Frame do
  describe 'validations' do
    it{ should belong_to(:game) }
    it{ should have_many(:rolls) }
  end
end
