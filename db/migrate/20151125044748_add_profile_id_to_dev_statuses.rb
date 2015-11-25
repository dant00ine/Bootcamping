class AddProfileIdToDevStatuses < ActiveRecord::Migration
  def change
    add_column :dev_statuses, :profile_id, :integer
  end
end
