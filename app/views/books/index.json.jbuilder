json.array!(@books) do |book|
  json.extract! book, :id, :title, :link, :genre, :image, :description, :date_publish
  json.url book_url(book, format: :json)
end
