module Spree

  class PickupLocation < Spree::Base

    ##Associations
    belongs_to :state, class_name: 'Spree::State'
    belongs_to :country, class_name: 'Spree::Country'

    ##Validations
    validates :name, :state, :country, presence: true

    geocoded_by :full_address

    ##Callbacks
    before_save :geocode, unless: -> {geocoded?}

    private

      def full_address
        [address1, address2, city, state.name, country.name].join(', ')
      end
  end

end
