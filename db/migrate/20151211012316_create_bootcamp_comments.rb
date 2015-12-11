class CreateBootcampComments < ActiveRecord::Migration
  def change
    create_table :bootcamp_comments do |t|
      t.text :body

      t.timestamps null: false
    end
  end
end
