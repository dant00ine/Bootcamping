class CreateBootcampReviews < ActiveRecord::Migration
  def change
    create_table :bootcamp_reviews do |t|
      t.integer :rating
      t.text :body

      t.timestamps null: false
    end
  end
end
