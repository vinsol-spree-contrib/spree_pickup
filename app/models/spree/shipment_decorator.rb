Spree::Shipment.class_eval do
  state_machine do
    event :ship do
      reset
      transition from: [:ready, :canceled], to: :shipped, if: :can_shipped?
    end
  end

  protected
    def can_shipped?
      !order.pick_up
    end

end
