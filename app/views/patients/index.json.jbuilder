json.array!(@patients1) do |patient|
  json.extract! patient, :id, :name, :hospitaladmin_id, :gender, :date_of_birth, :contact_no, :billing_id, :physician
  json.url patient_url(patient, format: :json)
end
