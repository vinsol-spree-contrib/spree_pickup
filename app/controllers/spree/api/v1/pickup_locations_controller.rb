module Spree
  module Api
    module V1
      class PickupLocationsController < Spree::Api::BaseController

        skip_before_action :authenticate_user

        def search
          @pickup_locations = Spree::PickupLocation.includes(address: [:state, :country])
                                                   .where(spree_addresses: {state_id: params[:s_id], country_id: params[:c_id]})
          render json: @pickup_locations.to_json(include: [:timings, {address: {include: [:state, :country]}}] )
        end

      end
    end
  end
end
