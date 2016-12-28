require 'spec_helper'

describe Spree::Api::PickupLocationsController, type: :controller do
  let!(:pickup_locations) { FactoryGirl.create_list(:pickup_location, 2, address: address) }
  let(:state) { FactoryGirl.create(:state) }
  let(:address) { FactoryGirl.create(:address, state: state, country: state.country) }

  before do
    allow(controller).to receive(:authenticate_spree_user!).and_return(true)
    @user = double(Spree::User, :generate_spree_api_key! => false, last_incomplete_spree_order: nil)
    allow(controller).to receive(:spree_current_user).and_return(@user)
  end

  describe '#search' do
    before { xhr :get, 'search', c_id: state.country.id, s_id: state.id }

    it 'assigns pickup_locations' do
      expect(assigns(:pickup_locations)).to eq(pickup_locations)
    end

    it 'renders json with success status' do
      expect(response.status).to eq(200)
    end
  end
end
