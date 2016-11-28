Spree::CheckoutController.class_eval do

  def update
    if params.dig(:order, :ship_address_attributes, :_destroy)
      @order.ship_address.try :destroy
      @order.ship_address_id = nil
    end
    if @order.update_from_params(params, permitted_checkout_attributes, request.headers.env)
      @order.temporary_address = !params[:save_user_address]
      unless @order.next
        flash[:error] = @order.errors.full_messages.join("\n")
        redirect_to(checkout_state_path(@order.state)) && return
      end

      if @order.completed?
        @current_order = nil
        flash.notice = Spree.t(:order_processed_successfully)
        flash['order_completed'] = true
        redirect_to completion_route
      else
        redirect_to checkout_state_path(@order.state)
      end
    else
      render :edit
    end
  end

  private

    def permitted_checkout_attributes
      permitted_attributes.checkout_attributes + [:pickup_location_id] + [
        bill_address_attributes: permitted_address_attributes,
        ship_address_attributes: permitted_address_attributes + [:_destroy],
        payments_attributes: permitted_payment_attributes,
        shipments_attributes: permitted_shipment_attributes
      ]
    end

    def before_address
      @order.bill_address ||= Spree::Address.build_default
      if @order.checkout_steps.include?('delivery')
        if(!params[:order].try(:[], :pickup_location_id) && params[:order].try(:[], :ship_address_attributes) || (params[:action].eql?('edit')))
          @order.ship_address ||= Spree::Address.build_default
        end
      end
    end

end
