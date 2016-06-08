module Spree

  class PickupLocation < Spree::Base

    ##Associations
    belongs_to :address

    ##Validations
    # validates :name, presence: true

    geocoded_by :full_address
    ##Callbacks
    after_validation :update_geocode, if: ->{ my_address_changed? || address.new_record? }

    accepts_nested_attributes_for :address

    private

      def update_geocode
        location = self.geocode
        self.update_columns(longitude: location.last, latitude: location.first)
      end

      def my_address_changed?
        address = self.address
        address.address1_changed? || address.address2_changed? || address.city_changed? || address.state_id_changed? || address.country_id_changed? || address.zipcode_changed?
      end

      def full_address
        address = self.address
        [address.address1, address.address2, address.zipcode, address.city, address.state.name, address.country.name].compact.join(', ')
      end
  end

end
