class CreateBootcampsAndProfiles < ActiveRecord::Migration
  def change
    create_table :bootcamps_profiles, id: false do |t|
      t.belongs_to :profile, index: true
      t.belongs_to :bootcamp, index: true
    end
  end
end
