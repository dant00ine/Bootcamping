class CreateBootcampsLocationsJointable < ActiveRecord::Migration
 def change
    create_table :bootcamps_locations, id: false do |t|
      t.integer :bootcamp_id
      t.integer :location_id
    end
 
    add_index :bootcamps_locations, :bootcamp_id
    add_index :bootcamps_locations, :location_id
  end
end