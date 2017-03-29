Spree::Api::V1::ShipmentsController.class_eval do

  def ship_for_pickup
    find_and_update_shipment
    @shipment.ship_for_pickup! if @shipment.ready?
    respond_with(@shipment, default_template: :show)
  end

  def ready_for_pickup
    find_and_update_shipment
    @shipment.ready_for_pickup! if @shipment.shipped_for_pickup? || @shipment.ready?
    respond_with(@shipment, default_template: :show)
  end

  def deliver
    find_and_update_shipment
    @shipment.deliver! if(@shipment.ready_for_pickup? || @shipment.shipped?)
    respond_with(@shipment, default_template: :show)
  end

end
