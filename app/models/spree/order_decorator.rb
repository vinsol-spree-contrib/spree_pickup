Spree::Order.class_eval do

  belongs_to :pickup_location, class_name: Spree::PickupLocation.to_s

  before_save :clone_pickup_address, if: :pickup_location_changed?

  SHIPMENT_STATES += %w(delivered)

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
      if pickup_location and self.ship_address.nil?
        self.ship_address = pickup_location.address.clone
      end
    end

    def pickup_location_changed?
      pickup_location_id != pickup_location_id_was
    end

end
