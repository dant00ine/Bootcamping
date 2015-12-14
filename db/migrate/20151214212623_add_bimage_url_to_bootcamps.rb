class AddBimageUrlToBootcamps < ActiveRecord::Migration
  def change
    add_column :bootcamps, :bimage_url, :string
  end
end
