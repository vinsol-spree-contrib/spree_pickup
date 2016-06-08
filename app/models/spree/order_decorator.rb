Spree::Order.class_eval do

  belongs_to :pickup_location, class_name: 'Spree::PickupLocation'

  def can_ship?
    (self.complete? || self.resumed? || self.awaiting_return? || self.returned?) && self.pickup_location_id.present?
  end

  private

  def has_available_shipment
    return unless has_step?("delivery")
    return unless has_step?('address') && address?
    return unless pickup_location_id.blank? && ship_address && ship_address.valid?
    # errors.add(:base, :no_shipping_methods_available) if available_shipping_methods.empty?
  end
end
