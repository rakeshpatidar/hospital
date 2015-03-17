json.array!(@photomsgs) do |photomsg|
  json.extract! photomsg, :photomsg_id, :physician, :patient_id, :image, :created_at
  json.url patient_url(photomsg, format: :json)
end
