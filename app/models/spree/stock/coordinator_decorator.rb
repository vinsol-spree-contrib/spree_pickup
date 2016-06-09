Spree::Stock::Coordinator.class_eval do

  def shipments
    pickup_address = order.pickup_location.try :address
    pickup_address.name_not_require = true if pickup_address
    packages.map do |package|
      package.to_shipment.tap { |s| s.address = order.ship_address || pickup_address}
    end
  end

end
