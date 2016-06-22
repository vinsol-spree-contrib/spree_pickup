Spree::Admin::Orders::CustomerDetailsController.class_eval do

  def order_params
    params.require(:order).permit(
      :email,
      :use_billing, :pickup_location_id,
      bill_address_attributes: permitted_address_attributes,
      ship_address_attributes: permitted_address_attributes
    )
  end

  private :order_params

end
