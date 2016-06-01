class AddPickupInOrders < ActiveRecord::Migration
  def change
    add_column :spree_orders, :pickup, :boolean, default: false
  end
end
