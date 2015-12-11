class AddBootcampIdToBootcampComments < ActiveRecord::Migration
  def change
    add_column :bootcamp_comments, :bootcamp_id, :integer
  end
end
