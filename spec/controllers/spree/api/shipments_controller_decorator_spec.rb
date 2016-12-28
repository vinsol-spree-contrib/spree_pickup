require 'spec_helper'

describe Spree::Api::ShipmentsController, type: :controller do
  let(:pickup_location) { FactoryGirl.create(:pickup_location) }
  let(:shipment) { FactoryGirl.create(:shipment, state: 'ready', order: FactoryGirl.create(:order, pickup_location_id: pickup_location.id)) }
  let(:user) { stub_model(Spree.user_class) }

  def current_api_user
    user = stub_model(Spree.user_class)
    allow(user).to receive_message_chain(:spree_roles, :pluck).and_return(["admin"])
    allow(user).to receive(:has_spree_role?).with("admin").and_return(true)
    user
  end

  describe '#ship_for_pickup' do
    context 'when user is not authorized do' do
      before do
        xhr :put, 'ship_for_pickup', id: shipment.id
      end

      it 'renders json with unathorized status' do
        expect(response.status).to eq(401)
      end
    end

    context 'when user is authorized' do
      before do
        allow(Spree.user_class).to receive(:find_by).with(hash_including(:spree_api_key)) { current_api_user }
        xhr :put, 'ship_for_pickup', id: shipment.id
      end

      it 'updates status of shippment to shipped_for_pickup' do
        shipment.reload
        expect(shipment.state).to eq('shipped_for_pickup')
      end

      it 'renders show template' do
        expect(response).to render_template(:show)
      end

      it 'renders json with success status' do
        expect(response.status).to eq(200)
      end
    end
  end

  describe '#ready_for_pickup' do
    context 'when user is not authorized do' do
      before do
        xhr :put, 'ready_for_pickup', id: shipment.id
      end

      it 'renders json with unathorized status' do
        expect(response.status).to eq(401)
      end
    end

    context 'when user is authorized' do
      before do
        allow(Spree.user_class).to receive(:find_by).with(hash_including(:spree_api_key)) { current_api_user }
        xhr :put, 'ready_for_pickup', id: shipment.id
      end

      it 'updates status of shippment to ' do
        shipment.reload
        expect(shipment.state).to eq('ready_for_pickup')
      end

      it 'renders show template' do
        expect(response).to render_template(:show)
      end

      it 'renders json with success status' do
        expect(response.status).to eq(200)
      end
    end
  end

  describe '#deliver' do
    context 'when user is not authorized do' do
      before do
        xhr :put, 'deliver', id: shipment.id
      end

      it 'renders json with unathorized status' do
        expect(response.status).to eq(401)
      end
    end

    context 'when user is authorized' do
      before do
        shipment.update_attributes(state: 'shipped')
        allow(Spree.user_class).to receive(:find_by).with(hash_including(:spree_api_key)) { current_api_user }
        xhr :put, 'deliver', id: shipment.id
      end

      it 'updates status of shippment to ' do
        shipment.reload
        expect(shipment.state).to eq('delivered')
      end

      it 'renders show template' do
        expect(response).to render_template(:show)
      end

      it 'renders json with success status' do
        expect(response.status).to eq(200)
      end
    end
  end
end
