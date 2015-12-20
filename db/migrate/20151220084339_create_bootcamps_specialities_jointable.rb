class CreateBootcampsSpecialitiesJointable < ActiveRecord::Migration
 def change
    create_table :bootcamps_specialities, id: false do |t|
      t.integer :bootcamp_id
      t.integer :speciality_id
    end
 
    add_index :bootcamps_specialities, :bootcamp_id
    add_index :bootcamps_specialities, :speciality_id
  end
end
