require 'spec_helper'

describe Roll do
  describe 'validations' do
    it{ should belong_to(:frame) }
    it{ should ensure_inclusion_of(:pins).in_range(0..Game::PINS) }
  end
end
