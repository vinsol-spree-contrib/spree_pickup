Spree::Admin::Orders::CustomerDetailsController.class_eval do

  def update
    if params.dig(:order, :ship_address_attributes, :_destroy)
      @order.ship_address.try :destroy
      @order.ship_address_id = nil
    end
    if @order.update_attributes(order_params)
      if params[:guest_checkout] == "false"
        @order.associate_user!(Spree.user_class.find(params[:user_id]), @order.email.blank?)
      end
      @order.next
      @order.refresh_shipment_rates(::Spree::ShippingMethod::DISPLAY_ON_FRONT_AND_BACK_END)
      flash[:success] = Spree.t('customer_details_updated')
      redirect_to edit_admin_order_url(@order)
    else
      render action: :edit
    end

  end

  def order_params
    params.require(:order).permit(
      :email,
      :use_billing, :pickup_location_id,
      bill_address_attributes: permitted_address_attributes,
      ship_address_attributes: permitted_address_attributes + [:_destroy]
    )
  end

  private :order_params

end
