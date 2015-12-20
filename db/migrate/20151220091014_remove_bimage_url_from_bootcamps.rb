class RemoveBimageUrlFromBootcamps < ActiveRecord::Migration
  def change
    remove_column :bootcamps, :bimage_url, :string
  end
end
