class AddPickupLocationIdInOrder < ActiveRecord::Migration
  def change
    add_column :spree_orders, :pickup_location_id, :integer
  end
end
