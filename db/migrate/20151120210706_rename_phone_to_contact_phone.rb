class RenamePhoneToContactPhone < ActiveRecord::Migration
  def self.up
  	rename_column :profiles, :phone, :contact_phone
  end
end
