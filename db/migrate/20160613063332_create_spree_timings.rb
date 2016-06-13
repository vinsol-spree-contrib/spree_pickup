class CreateSpreeTimings < ActiveRecord::Migration
  def change
    create_table :spree_timings do |t|
      t.integer :day_id
      t.integer :pickup_location_id
    end
  end
end
