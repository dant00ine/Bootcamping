class AddProfessionIdToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :profession_id, :integer
  end
end
