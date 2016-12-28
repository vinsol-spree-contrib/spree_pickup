FactoryGirl.define do
  factory :pickup_location, class: Spree::PickupLocation do
    name 'Sample pickup location'
    address FactoryGirl.create(:address)
    phone '12345'
    latitude '22.2'
    longitude '44.4'
    start_time Time.now
    end_time Time.now + 1.hour

    trait :with_timings do |pickup_location|
      timings { FactoryGirl.build_list(:timing, 2, pickup_location_id: pickup_location.id) }
    end
  end
end
