require 'open-uri'
require 'json'

isbns = ['9780140328721', '9780143127741']

isbns.each do |isbn|
  url = "https://openlibrary.org/api/books?bibkeys=ISBN:#{isbn}&format=json&jscmd=data"
  json = URI.open(url).read
  data = JSON.parse(json)
  info = data["ISBN:#{isbn}"]
  next unless info

  book = Book.find_or_initialize_by(isbn: isbn)
  book.title = info['title']
  book.description = info.dig('notes') || info['subtitle'] || ''
  book.pages = info['number_of_pages']
  book.published_at = info['publish_date']
  book.metadata = info
  book.price_cents = 1990
  book.stock = 10
  book.save!

  (info['authors'] || []).each do |a|
    name = a['name']
    author = Author.find_or_create_by!(name: name)
    book.authors << author unless book.authors.include?(author)
  end

  if cover = info.dig('cover', 'large') || info.dig('cover', 'medium') || info.dig('cover', 'small')
    begin
      file = URI.open(cover)
      book.cover_images.attach(io: file, filename: "#{isbn}.jpg")
    rescue => e
      Rails.logger.warn "Can't attach cover #{isbn}: #{e.message}"
    end
  end
end
