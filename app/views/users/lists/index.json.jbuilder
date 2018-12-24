json.array!(@lists) do |list|
  json.extract! list, :id, :new, :position
  json.url list_url(list, format: :json)
end
