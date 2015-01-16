json.array!(@patients) do |patient|
  json.extract! patient, :id, :first-name, :last-name, :gender, :date-of-birth, :contact-no, :address
  json.url patient_url(patient, format: :json)
end
