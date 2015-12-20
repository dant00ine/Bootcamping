class AddLinkedinToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :contact_linkedin, :string
  end
end
