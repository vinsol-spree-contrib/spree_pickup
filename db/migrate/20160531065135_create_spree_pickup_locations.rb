class CreateSpreePickupLocations < ActiveRecord::Migration
  def change
    create_table :spree_pickup_locations do |t|
      t.string   :name
      t.integer  :address_id
      t.string   :phone
      t.float    :latitude
      t.float    :longitude
      t.time     :start_time
      t.time     :end_time
      t.timestamps
    end
  end
end
