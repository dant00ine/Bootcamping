class RemoveBootcampAdminFromProfules < ActiveRecord::Migration
  def change
    remove_column :profiles, :bootcamp_admin, :integer
  end
end
