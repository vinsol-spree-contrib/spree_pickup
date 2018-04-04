class CreateSpreePickupLocations < SpreeExtension::Migration[4.2]
  def change
    create_table :spree_pickup_locations do |t|
      t.string   :name
      t.integer  :address_id, index: true
      t.string   :phone
      t.float    :latitude
      t.float    :longitude
      t.time     :start_time
      t.time     :end_time
      t.timestamps
    end
  end
end
