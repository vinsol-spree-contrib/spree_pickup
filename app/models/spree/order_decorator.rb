Spree::Order.class_eval do

  belongs_to :pickup_location, class_name: Spree::PickupLocation.to_s

  validate :ensure_pickup_or_ship_address_present, if: -> { bill_address && !cart? }

  def pickup_address
    pickup_location.try :address
  end

  def pickup?
    pickup_location_id.present?
  end

  def ship_address_attributes= val
    super if ship_address
  end

  private

    def ensure_pickup_or_ship_address_present
      unless((pickup_location && !ship_address) || (!pickup_location && ship_address))
        errors[:base] << Spree.t(:ensure_pickup_or_ship_address_present)
      end
    end

    def has_available_shipment
      return unless has_step?('delivery')
      return unless has_step?('address') && address?
      return unless pickup_location_id.blank? && ship_address && ship_address.valid?
    end

end
