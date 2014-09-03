json.array!(@inspirations) do |inspiration|
  json.extract! inspiration, :id, :quote, :page_number, :likes
  json.url inspiration_url(inspiration, format: :json)
end
