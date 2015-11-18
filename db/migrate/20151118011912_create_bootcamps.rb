class CreateBootcamps < ActiveRecord::Migration
  def change
    create_table :bootcamps do |t|
      t.string :title
      t.text :about
      t.string :image
      t.string :speciality
      t.string :location
      t.string :website
      t.string :email
      t.string :facebook
      t.string :twitter
      t.string :job_guarantee
      t.string :job_assistance
      t.string :apprenticeship
      t.string :accreditation
      t.string :post_grad_resources
      t.string :housing
      t.string :visa_assistance

      t.timestamps null: false
    end
  end
end
