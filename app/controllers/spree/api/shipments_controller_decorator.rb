Spree::Api::ShipmentsController.class_eval do

  def pickup_ship
    find_and_update_shipment
    @shipment.pickup_ship! if @shipment.ready?
    respond_with(@shipment, default_template: :show)
  end

  def pickup_ready
    find_and_update_shipment
    @shipment.pickup_ready! if @shipment.pickup_shipped? || @shipment.ready?
    respond_with(@shipment, default_template: :show)
  end

  def deliver
    find_and_update_shipment
    @shipment.deliver! if(@shipment.pickup_ready? || @shipment.shipped?)
    respond_with(@shipment, default_template: :show)
  end


end
