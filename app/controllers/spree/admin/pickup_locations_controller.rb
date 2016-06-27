module Spree
  module Admin

    class PickupLocationsController < ResourceController

      before_action :set_country, only: :new

      def index
        @pickup_locations = @pickup_locations.includes(address: [:state, :country])
      end

      def set_country
        @pickup_location.address = Spree::Address.build_default
        rescue ActiveRecord::RecordNotFound
        flash[:error] = Spree.t(:pickup_locations_need_a_default_country)
        redirect_to admin_pickup_locations_path
      end

      private :set_country

    end
  end
end
