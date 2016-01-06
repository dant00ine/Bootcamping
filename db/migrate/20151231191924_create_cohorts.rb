class CreateCohorts < ActiveRecord::Migration
  def change
    create_table :cohorts do |t|
      t.string :month

      t.timestamps null: false
    end
  end
end
