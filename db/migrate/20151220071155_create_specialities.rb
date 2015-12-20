class CreateSpecialities < ActiveRecord::Migration
  def change
    create_table :specialities do |t|
      t.string :title

      t.timestamps null: false
    end
  end
end
