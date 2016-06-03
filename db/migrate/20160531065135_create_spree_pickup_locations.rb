class CreateSpreePickupLocations < ActiveRecord::Migration
  def change
    create_table :spree_pickup_locations do |t|
      t.string   :name
      t.string   :address1
      t.string   :address2
      t.string   :city
      t.integer  :state_id, null: false, index: true
      t.integer  :country_id, null: false, index: true
      t.string   :zipcode
      t.string   :phone
      t.float    :latitude
      t.float    :longitude
      t.text     :functioning_details
      t.timestamps
    end
  end
end
