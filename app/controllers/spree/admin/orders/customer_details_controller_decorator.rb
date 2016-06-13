module Spree
  module Admin
    module Orders
      CustomerDetailsController.class_eval do

        def edit
          @order.bill_address ||= Address.build_default
          if @order.checkout_steps.include?('delivery')
            if !params[:order].try(:[], :pickup_location_id) && params[:order].try(:[], :ship_address_attributes)
              @order.ship_address ||= Address.build_default(country_id: country_id)
            elsif(['edit', 'show'].include?(params[:action]))
              @order.ship_address ||= Address.build_default
            end
          end
        end

        private
          def order_params
            params.require(:order).permit(
              :email,
              :use_billing, :pickup_location_id,
              bill_address_attributes: permitted_address_attributes,
              ship_address_attributes: permitted_address_attributes
            )
          end

      end
    end
  end
end
