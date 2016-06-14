Spree::Admin::Orders::CustomerDetailsController.class_eval do

  before_action :set_default_address, only: [:edit, :show]

  def edit
  end

  def set_default_address
    @order.bill_address ||= Address.build_default
    if @order.checkout_steps.include?('delivery')
      if !params[:order].try(:[], :pickup_location_id) && params[:order].try(:[], :ship_address_attributes)
        @order.ship_address ||= Address.build_default(country_id: country_id)
      elsif(['edit', 'show'].include?(params[:action]))
        @order.ship_address ||= Address.build_default
      end
    end
  end

  def order_params
    params.require(:order).permit(
      :email,
      :use_billing, :pickup_location_id,
      bill_address_attributes: permitted_address_attributes,
      ship_address_attributes: permitted_address_attributes
    )
  end

  private :set_default_address, :order_params

end
