Spree::Stock::Coordinator.class_eval do

  def shipments
    packages.map do |package|
      package.to_shipment.tap { |s| s.address = order.ship_address || order.pickup_address}
    end
  end

end
