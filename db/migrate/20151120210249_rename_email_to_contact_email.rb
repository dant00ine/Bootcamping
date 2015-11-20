class RenameEmailToContactEmail < ActiveRecord::Migration
  def self.up
  	rename_column :profiles, :email, :contact_email
  end
end
