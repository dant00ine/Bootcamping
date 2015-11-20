class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :nick_name
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :email
      t.string :website

      t.timestamps null: false
    end
  end
end
