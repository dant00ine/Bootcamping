json.array!(@cohorts) do |cohort|
  json.extract! cohort, :id, :month
  json.url cohort_url(cohort, format: :json)
end
