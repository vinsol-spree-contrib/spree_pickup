module Spree
  module Admin

    class PickupLocationsController < ResourceController

      before_action :set_country, only: :new

      def create
        invoke_callbacks(:create, :before)
        @object.attributes = permitted_resource_params
        if @object.save
          invoke_callbacks(:create, :after)
          flash[:success] = flash_message_for(@object, :successfully_created)
          respond_with(@object) do |format|
            format.html { redirect_to location_after_save }
            format.js   { render layout: false }
          end
        else
          invoke_callbacks(:create, :fails)
          respond_with(@object) do |format|
            format.html { render action: :new }
            format.js { render layout: false }
          end
        end
      end

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
