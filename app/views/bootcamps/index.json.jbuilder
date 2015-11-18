json.array!(@bootcamps) do |bootcamp|
  json.extract! bootcamp, :id, :title, :about, :image, :speciality, :location, :website, :email, :facebook, :twitter, :job_guarantee, :job_assistance, :apprenticeship, :accreditation, :post_grad_resources, :housing, :visa_assistance
  json.url bootcamp_url(bootcamp, format: :json)
end
