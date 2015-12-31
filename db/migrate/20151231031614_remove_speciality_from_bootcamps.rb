class RemoveSpecialityFromBootcamps < ActiveRecord::Migration
  def change
    remove_column :bootcamps, :speciality, :string
  end
end
