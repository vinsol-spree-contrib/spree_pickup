require 'spec_helper'

describe Spree::Admin::PickupLocationsController do
  let(:user) { mock_model(Spree::User) }

  describe '#new' do
    before(:each) do
      allow(controller).to receive(:spree_current_user).and_return(user)
      allow(user).to receive(:generate_spree_api_key!).and_return(true)
      allow(controller).to receive(:authorize!).and_return(true)
      allow(controller).to receive(:authorize_admin).and_return(true)
    end

    context 'when record is found' do
      before { get :new }

      it 'renders response with success status' do
        expect(response.status).to eq(200)
      end

      it 'builds a new pickup_location and address' do
        expect(assigns(:pickup_location)).to be_an_instance_of(Spree::PickupLocation)
        expect(assigns(:pickup_location).address).to be_an_instance_of(Spree::Address)
      end
    end

    context 'when record is not found' do
      before do
        allow(Spree::Address).to receive(:build_default).and_raise(ActiveRecord::RecordNotFound)
        get :new
      end

      it 'renders response with redirect status' do
        expect(response.status).to eq(302)
      end

      it 'redirects to admin_pickup_locations_path' do
        expect(response).to redirect_to(admin_pickup_locations_path)
      end
    end
  end

  describe '#index' do
    let!(:pickup_locations) { FactoryGirl.create_list(:pickup_location, 2) }

    before(:each) do
      allow(controller).to receive(:spree_current_user).and_return(user)
      allow(user).to receive(:generate_spree_api_key!).and_return(true)
      allow(controller).to receive(:authorize!).and_return(true)
      allow(controller).to receive(:authorize_admin).and_return(true)
      get :index
    end

    it 'renders response with success status' do
      expect(response.status).to eq(200)
    end

    it 'renders index template' do
      expect(response).to render_template(:index)
    end
  end
end
