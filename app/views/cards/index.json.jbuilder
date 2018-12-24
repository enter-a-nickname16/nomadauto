json.array!(@cards) do |card|
  json.extract! card, :id, :list_id, :name, :position
  json.url card_url(card, format: :json)
end
