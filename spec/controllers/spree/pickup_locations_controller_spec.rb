require 'spec_helper'

describe Spree::PickupLocationsController, :type => :controller do
  let!(:pickup_locations) { FactoryGirl.create_list(:pickup_location, 2, address: address) }
  let(:state) { FactoryGirl.create(:state) }
  let(:address) { FactoryGirl.create(:address, state: state, country: state.country) }

  before do
    allow(controller).to receive(:authenticate_spree_user!).and_return(true)
    @user = double(Spree::User, :generate_spree_api_key! => false, last_incomplete_spree_order: nil)
    allow(controller).to receive(:spree_current_user).and_return(@user)
  end

  describe '#index' do

    context 'when state and country variables are not present' do
      before { xhr :get, 'index' }

      it 'assigns base_scope' do
        expect(assigns(:base_scope)).to eq(pickup_locations)
      end

      it 'does not assign state' do
        expect(assigns(:state)).to be_nil
      end

      it 'does not assign country' do
        expect(assigns(:country)).to be_nil
      end
    end

    context 'when state and country params are avialable' do
      let!(:other_address_pickup_locations) { FactoryGirl.create_list(:pickup_location, 2) }

      before do
        xhr :get, 'index', s_id: state.id, c_id: state.country.id
      end

      it 'assigns state' do
        expect(assigns(:state)).to eq(state)
      end

      it 'assigns country' do
        expect(assigns(:country)).to eq(state.country)
      end
    end
  end
end
