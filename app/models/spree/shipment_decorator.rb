Spree::Shipment.class_eval do

  scope :delivered, -> { with_state('delivered') }
  scope :pickup_shipped, -> { with_state('pickup_shipped') }
  scope :pickup_ready, -> { with_state('pickup_ready') }

  state_machine do

    event :ship do
      reset
      transition from: [:ready, :canceled], to: :shipped, if: :can_shipped?
    end
    after_transition to: :shipped, do: :after_ship

    event :pickup_ship do
      transition from: [:ready, :canceled], to: :pickup_shipped, if: :can_pickup_shipped?
    end
    after_transition to: :pickup_shipped, do: :after_ship

    event :pickup_ready do
      transition from: [:ready, :canceled, :pickup_shipped], to: :pickup_ready
    end

    event :deliver do
      transition from: [:pickup_ready, :shipped], to: :delivered
    end

    after_transition from: :canceled, to: [:pickup_ready, :pickup_shipped], do: :after_resume
    after_transition to: [:pickup_ready, :deliver], do: :update_order_shipment

  end

  private
    def can_shipped?
      order.ship_address_id.present?
    end

    def can_pickup_shipped?
      order.pickup_location_id.present?
    end

    def update_order_shipment
      Spree::ShipmentHandler.factory(self).send :update_order_shipment_state
    end

end
