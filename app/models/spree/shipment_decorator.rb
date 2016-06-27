Spree::Shipment.class_eval do

  scope :delivered, -> { with_state('delivered') }
  scope :shipped_for_pickup, -> { with_state('shipped_for_pickup') }
  scope :ready_for_pickup, -> { with_state('ready_for_pickup') }

  state_machine do

    # event :ship do
    #   reset
    #   transition from: [:ready, :canceled], to: :shipped, if: :can_shipped?
    # end
    # after_transition to: :shipped, do: :after_ship

    event :ship_for_pickup do
      transition from: [:ready, :canceled], to: :shipped_for_pickup, if: :can_shipped_for_pickup?
    end
    after_transition to: :shipped_for_pickup, do: :after_ship

    event :ready_for_pickup do
      transition from: [:ready, :canceled, :shipped_for_pickup], to: :ready_for_pickup
    end

    event :deliver do
      transition from: [:ready_for_pickup, :shipped], to: :delivered
    end

    after_transition from: :canceled, to: [:ready_for_pickup, :shipped_for_pickup], do: :after_resume
    after_transition to: [:ready_for_pickup, :delivered], do: :update_order_shipment

  end

  def can_shipped?
    order.can_ship?
  end

  def can_shipped_for_pickup?
    order.pickup_location_id.present?
  end

  def update_order_shipment
    Spree::ShipmentHandler.factory(self).send :update_order_shipment_state
  end

  private :can_shipped?, :can_shipped_for_pickup?, :update_order_shipment

end
