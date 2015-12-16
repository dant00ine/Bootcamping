class RemoveNickNameFromProfiles < ActiveRecord::Migration
  def change
    remove_column :profiles, :nick_name, :string
  end
end
