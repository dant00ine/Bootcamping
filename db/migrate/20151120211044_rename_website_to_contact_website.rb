class RenameWebsiteToContactWebsite < ActiveRecord::Migration
  def self.up
  	rename_column :profiles, :website, :contact_website
  end
end
