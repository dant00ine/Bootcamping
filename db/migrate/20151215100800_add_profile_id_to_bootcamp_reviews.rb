class AddProfileIdToBootcampReviews < ActiveRecord::Migration
  def change
    add_column :bootcamp_reviews, :profile_id, :integer
  end
end
