require 'spec_helper'

describe Spree::Shipment, type: :model do

  let!(:delivered_shipment) { FactoryGirl.create(:shipment, state: 'delivered') }
  let!(:shipped_for_pickup_shipment) { FactoryGirl.create(:shipment, state: 'shipped_for_pickup') }
  let!(:ready_for_pickup_shipment) { FactoryGirl.create(:shipment, state: 'ready_for_pickup') }
  let(:shipment) { FactoryGirl.create(:shipment) }

  describe 'scopes' do
    describe 'delivered' do
      it 'returns delivered shipments' do
        expect(Spree::Shipment.delivered.first).to eq(delivered_shipment)
      end
    end

    describe 'shipped_for_pickup' do
      it 'returns shipment which are ready for pickup' do
        expect(Spree::Shipment.shipped_for_pickup.first).to eq(shipped_for_pickup_shipment)
      end
    end

    describe 'ready_for_pickup' do
      it 'returns shipment which are ready for pickup' do
        expect(Spree::Shipment.ready_for_pickup.first).to eq(ready_for_pickup_shipment)
      end
    end
  end

  describe 'instance methods' do
    describe '#finalized' do
      context 'when finalized state includes shipment state' do
        it 'returns true' do
          expect(ready_for_pickup_shipment.finalized?).to be_truthy
        end
      end

      context 'when finalized state does not include shipment state' do
        it 'returns false' do
          expect(shipment.finalized?).to be_falsey
        end
      end
    end
  end

  describe '#private methods' do
    describe 'can_shipped?' do
      it 'returns shipping status as per order shipping status' do
        expect(shipment.send(:can_shipped?)).to eq(shipment.order.can_ship?)
      end
    end

    describe 'can_shipped_for_pickup?' do
      it 'returns pickup status as per order pickup status' do
        expect(shipment.send(:can_shipped_for_pickup?)).to eq(shipment.order.pickup?)
      end
    end

    describe 'update_order_shipment' do
      it 'updates order shipment' do
        expect(shipment.send(:update_order_shipment)).to be_truthy
      end
    end
  end
end
