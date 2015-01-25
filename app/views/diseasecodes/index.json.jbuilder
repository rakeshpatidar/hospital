json.array!(@diseasecodes) do |diseasecode|
  json.extract! diseasecode, :id, :disease, :code, :hospitaladmin_id, :description
  json.url diseasecode_url(diseasecode, format: :json)
end
