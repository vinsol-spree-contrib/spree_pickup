module Spree
  CheckoutController.class_eval do

    def permitted_checkout_attributes
      permitted_attributes.checkout_attributes + [:pickup_location_id] + [
        bill_address_attributes: permitted_address_attributes,
        ship_address_attributes: permitted_address_attributes + [:_destroy],
        payments_attributes: permitted_payment_attributes,
        shipments_attributes: permitted_shipment_attributes
      ]
    end

    def before_address
      # if the user has a default address, a callback takes care of setting
      # that; but if he doesn't, we need to build an empty one here
      @order.bill_address ||= Address.build_default
      if @order.checkout_steps.include?('delivery')
        if !params[:order].try(:[], :pickup_location_id) && params[:order].try(:[], :ship_address_attributes)
          @order.ship_address ||= Address.build_default
        elsif(params[:action].eql?('edit'))
          @order.ship_address ||= Address.build_default
        end
      end
    end


  end
end
