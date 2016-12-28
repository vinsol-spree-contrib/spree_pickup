require 'spec_helper'

describe Spree::Timing, type: :model do

  describe 'validations' do
    it { is_expected.to validate_presence_of(:day_id) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:pickup_location) }
  end
end
