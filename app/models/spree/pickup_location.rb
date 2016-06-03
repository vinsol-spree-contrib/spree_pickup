module Spree

  class PickupLocation < Spree::Base

    ##Associations
    belongs_to :state, class_name: 'Spree::State'
    belongs_to :country, class_name: 'Spree::Country'

    ##Validations
    validates :name, :state, :country, presence: true

    geocoded_by :full_address

    ##Callbacks
    before_save :geocode, if: :address_changed?

    private

      def address_changed?
        address1_changed? || address2_changed? || city_changed? || state_changed? || country_changed? || zipcode_changed?
      end

      def full_address
        [address1, address2, zipcode, city, state.name, country.name].compact.join(', ')
      end
  end

end
