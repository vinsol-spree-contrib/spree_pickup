class CreateSpreeTimings < ActiveRecord::Migration[4.2]
  def change
    create_table :spree_timings do |t|
      t.integer :day_id
      t.integer :pickup_location_id, index: true
    end
  end
end
