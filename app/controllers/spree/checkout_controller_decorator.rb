module Spree
  CheckoutController.class_eval do

    def before_address
      # if the user has a default address, a callback takes care of setting
      # that; but if he doesn't, we need to build an empty one here
      @order.bill_address ||= Address.build_default
      @order.ship_address ||= Address.build_default if @order.checkout_steps.include?('delivery') && !params[:order].try(:[], :pickup_location_id)
    end
  end
end
