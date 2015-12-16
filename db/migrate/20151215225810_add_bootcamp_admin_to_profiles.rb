class AddBootcampAdminToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :bootcamp_admin, :integer
  end
end