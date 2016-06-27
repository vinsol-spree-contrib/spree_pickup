class AddPickableInShippingMethods < ActiveRecord::Migration
  def change
    add_column :spree_shipping_methods, :pickupable, :boolean, default: false
  end
end
