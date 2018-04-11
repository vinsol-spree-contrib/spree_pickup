Spree::Order.class_eval do

  belongs_to :pickup_location, class_name: Spree::PickupLocation.to_s

  before_validation :clone_pickup_address, if: :pickup_location_changed?

  Spree::Order::SHIPMENT_STATES += %w(delivered)

  _validators.delete(:shipment_state)

  _validate_callbacks.each do |callback|
    if callback.raw_filter.respond_to? :attributes
      callback.raw_filter.attributes.delete :shipment_state
    end
  end

  validates :shipment_state,  inclusion:  { in: Spree::Order::SHIPMENT_STATES, allow_blank: true }

  def pickup_address
    ship_address
  end

  def pickup?
    pickup_location_id.present?
  end

  def ship_address_attributes= val
    if pickup_location_changed? && pickup?
      super(pickup_location.address.attributes.except('id', 'updated_at', 'created_at'))
    else
      super
    end
  end

  private

    def clone_pickup_address
      if pickup_location and self.ship_address.blank?
        self.ship_address = pickup_location.address.clone
      end
    end

    def pickup_location_changed?
      pickup_location_id != pickup_location_id_was
    end

end
