Spree::Shipment::FINALIZED_STATES = ['delivered', 'shipped', 'ready_for_pickup', 'shipped_for_pickup']
Spree::Shipment.class_eval do

  scope :delivered, -> { with_state('delivered') }
  scope :shipped_for_pickup, -> { with_state('shipped_for_pickup') }
  scope :ready_for_pickup, -> { with_state('ready_for_pickup') }

  state_machine do

    event :ship_for_pickup do
      transition from: [:ready, :canceled], to: :shipped_for_pickup, if: :can_shipped_for_pickup?
    end
    after_transition to: :shipped_for_pickup, do: :after_ship

    event :ready_for_pickup do
      transition from: [:ready, :canceled], to: :ready_for_pickup
      transition from: :shipped_for_pickup, to: :ready_for_pickup
    end
    after_transition from: [:ready, :canceled], to: :ready_for_pickup, do: :after_ship

    event :deliver do
      transition from: [:ready_for_pickup, :shipped], to: :delivered
    end

    after_transition from: :canceled, to: [:ready_for_pickup, :shipped_for_pickup], do: :after_resume
    after_transition to: :delivered, do: :update_order_shipment

  end

  def finalized?
    self.class::FINALIZED_STATES.include?(state)
  end

  def determine_state(order)
    return 'canceled' if order.canceled?
    return 'pending' unless order.can_ship?
    return 'pending' if inventory_units.any? &:backordered?
    return 'shipped' if shipped?
    return 'ready_for_pickup' if ready_for_pickup?
    return 'shipped_for_pickup' if shipped_for_pickup?
    return 'delivered' if delivered?
    order.paid? || Spree::Config[:auto_capture_on_dispatch] ? 'ready' : 'pending'
  end

  private

    def can_shipped?
      order.can_ship?
    end

    def can_shipped_for_pickup?
      order.pickup?
    end

    def update_order_shipment
      Spree::ShipmentHandler.factory(self).send :update_order_shipment_state
    end

end
