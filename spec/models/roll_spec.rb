require 'spec_helper'

describe Roll do
  describe 'validations' do
    it{ should belong_to(:frame) }
  end
end
