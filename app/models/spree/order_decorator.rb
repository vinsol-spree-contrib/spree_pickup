Spree::Order.class_eval do

  belongs_to :pickup_location, class_name: 'Spree::PickupLocation'

  validate :ensure_pickup_or_ship_address_present, if: :bill_address

  accepts_nested_attributes_for :ship_address, allow_destroy: true

  def pickup_address
    pickup_location.try :address
  end

  def can_ship?
    (self.complete? || self.resumed? || self.awaiting_return? || self.returned?) && self.ship_address_id.present?
  end

  def pickup?
    pickup_location_id.present?
  end

  def ensure_pickup_or_ship_address_present
    unless((pickup_location && !ship_address) || (!pickup_location && ship_address))
      errors[:base] << 'Either Ship Address or Pickup Address must be present'
    end
  end

  def has_available_shipment
    return unless has_step?('delivery')
    return unless has_step?('address') && address?
    return unless pickup_location_id.blank? && ship_address && ship_address.valid?
  end

  private :ensure_pickup_or_ship_address_present, :has_available_shipment

end
