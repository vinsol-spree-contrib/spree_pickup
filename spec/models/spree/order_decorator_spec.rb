require 'spec_helper'

describe Spree::Order, type: :model do

  let!(:pickup_location) { FactoryGirl.create(:pickup_location) }
  let(:order) { FactoryGirl.create(:order) }
  let(:order_with_pickup_location) { FactoryGirl.create(:order, pickup_location_id: pickup_location.id) }
  let(:address) { FactoryGirl.create(:address, firstname: 'Samplefirst', lastname: 'Samplelast', company: 'Samplecompany') }
  let(:address1) { FactoryGirl.create(:address) }

  describe '#callbacks' do
    it { is_expected.to callback(:clone_pickup_address).before(:save).if(:pickup_location_changed?) }
  end

  describe '#associations' do
    it { is_expected.to belong_to(:pickup_location) }
  end

  describe '#pickup_address' do
    it 'returns ship_address of order' do
      expect(order_with_pickup_location.pickup_address).to eq(order_with_pickup_location.ship_address)
    end
  end

  describe '#pickup?' do
    context 'when pickup address is present' do
      before { order_with_pickup_location.pickup_location = pickup_location }

      it 'returns true' do
        expect(order_with_pickup_location.pickup?).to eq(true)
      end
    end

    context 'when pickup address is not present' do
      it 'returns false' do
        expect(order.pickup?).to eq(false)
      end
    end
  end

  describe '#ship_address_attributes=' do
    context 'if pickup_location_changed? and pickup?' do
      before do
        order_with_pickup_location.pickup_location = FactoryGirl.create(:pickup_location, address: address1)
        order_with_pickup_location.ship_address_attributes=(address.attributes)
      end

      it 'returns pickup locations address attributes' do
        expect(order_with_pickup_location.pickup_location.address.attributes.except('id', 'updated_at', 'created_at')).to eq(address1.attributes.except('id', 'updated_at', 'created_at'))
      end
    end

    context 'when pickup_location_changed is false or pickup is false' do
      before do
        order_with_pickup_location.update_attributes(pickup_location_id: nil)
      end

      it 'calls super with pickup_location params' do
        expect(order_with_pickup_location.ship_address_attributes=(address.attributes.except('id', 'updated_at', 'created_at'))).to eq(address.attributes.except('id', 'updated_at', 'created_at'))
      end
    end
  end

  describe '#private methods' do
    describe '#clone_pickup_address' do
      context 'when ship address is nil' do
        before { order_with_pickup_location.ship_address = nil }
        it 'assigns ship address to order' do
          expect(order_with_pickup_location.send(:clone_pickup_address)).to eq(pickup_location.address.clone)
        end
      end

      context 'when ship address is not nil' do
        it 'returns nil' do
          expect(order_with_pickup_location.send(:clone_pickup_address)).to eq(nil)
        end
      end
    end
  end
end
