Spree::Shipment.class_eval do

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

  end

  protected
    def can_shipped?
      order.ship_address_id.present?
    end

    def can_pickup_shipped?
      order.pickup_location_id.present?
    end

end
