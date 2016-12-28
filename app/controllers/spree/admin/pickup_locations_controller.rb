module Spree
  module Admin

    class PickupLocationsController < ResourceController

      before_action :set_country, only: :new

      private
        def set_country
          @pickup_location.address = Spree::Address.build_default
          rescue ActiveRecord::RecordNotFound
          flash[:error] = Spree.t(:pickup_locations_need_a_default_country)
          redirect_to admin_pickup_locations_path
        end

        def collection
          super.includes(address: [:state, :country]).page(params[:page]).per(params[:per_page])
        end

    end
  end
end
