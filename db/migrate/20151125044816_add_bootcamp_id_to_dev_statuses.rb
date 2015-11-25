class AddBootcampIdToDevStatuses < ActiveRecord::Migration
  def change
    add_column :dev_statuses, :bootcamp_id, :integer
  end
end
