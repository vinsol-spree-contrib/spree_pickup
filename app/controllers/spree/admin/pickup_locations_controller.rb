module Spree
  module Admin

    class PickupLocationsController < ResourceController
      before_action :set_country, only: :new

      def index
        @pickup_locations = @pickup_locations.includes(address: [:state, :country])
      end

      private

        def set_country
          @pickup_location.address = ::Spree::Address.new
          @pickup_location.address.country = Spree::Country.default
          rescue ActiveRecord::RecordNotFound
          flash[:error] = Spree.t(:pickup_locations_need_a_default_country)
          redirect_to admin_pickup_locations_path
        end

    end
  end
end
