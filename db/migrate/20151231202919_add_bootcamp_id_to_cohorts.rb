class AddBootcampIdToCohorts < ActiveRecord::Migration
  def change
    add_column :cohorts, :bootcamp_id, :integer
  end
end
