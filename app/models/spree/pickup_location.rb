module Spree

  class PickupLocation < Spree::Base

    attr_accessor :open_day_ids, :open_day_ids_was

    ##Associations
    belongs_to :address
    has_many :timings, dependent: :destroy, class_name: 'Spree::Timing'

    ##Validations
    validates :longitude, :latitude, :name, :address, :start_time, :end_time, presence: true
    validate :end_time_must_be_greater_than_start_time

    geocoded_by :full_address

    ##Callbacks
    before_save :create_timings, if: :open_day_ids_changed?
    before_validation :update_geocode, if: ->{ my_address_changed? || address.new_record? }
    after_initialize :set_open_day_ids

    accepts_nested_attributes_for :address

    def set_open_day_ids
      self.open_day_ids = self.open_day_ids_was = timings.map(&:day_id)
    end

    def create_timings
      self.timings.delete_all
      self.timings = (open_day_ids.map{|i| Timing.new(day_id: i)})
    end

    def update_geocode
      location = self.geocode
      self.longitude = location.try :last
      self.latitude = location.try :first
    end

    def my_address_changed?
      address = self.address
      address.address1_changed? || address.address2_changed? || address.city_changed? || address.state_id_changed? || address.country_id_changed? || address.zipcode_changed?
    end

    def full_address
      address = self.address
      [address.address1, address.address2, address.zipcode, address.city, address.state.name, address.country.name].compact.join(', ')
    end

    def end_time_must_be_greater_than_start_time
      errors[:end_time] << 'must be greater than start time' if start_time >= end_time
    end

    def open_day_ids_changed?
      self.open_day_ids -= [""]
      !((open_day_ids.length == open_day_ids_was.length) && (open_day_ids.map(&:to_i) - open_day_ids_was).length == 0)
    end

    private :set_open_day_ids, :create_timings, :my_address_changed?, :full_address,
            :end_time_must_be_greater_than_start_time, :update_geocode

  end

end
