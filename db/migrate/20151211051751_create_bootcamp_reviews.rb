class CreateBootcampReviews < ActiveRecord::Migration
  def change
    create_table :bootcamp_reviews do |t|
      t.integer :review

      t.timestamps null: false
    end
  end
end
