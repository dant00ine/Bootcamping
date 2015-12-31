class RemoveLocationFromBootcamps < ActiveRecord::Migration
  def change
    remove_column :bootcamps, :location, :string
  end
end
