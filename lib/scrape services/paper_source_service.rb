scrape_data.each do |data|
  html_file = URI.open(data[:url]).read
  html_doc = Nokogiri::HTML(html_file)

  # Find or create a 'pen' category
  category = Category.find_or_create_by(name: data[:category])

  html_doc.css(".product-item-info").each do |product_info|
    name = product_info.css(".product-item-link").text.strip
    price_str = product_info.css(".price").text.strip

    # Remove "$" symbol, convert to float, multiply by 100, and round to integer
    price_in_cents = (price_str.delete("$").to_f * 100).round

    image_url = product_info.css(".product-image-wrapper").children.attr('data-src').value
    puts "got image url #{image_url}"
    product_image = URI.open(image_url)

    # Extract the URL of the individual product page
    product_page_url = product_info.css(".product-item-link").attr('href').value

    # Make an HTTP request to the individual product page
    product_page_html = URI.open(product_page_url).read
    product_page_doc = Nokogiri::HTML(product_page_html)

    # Scrape the product description from the product page
    description = product_page_doc.css(".value").text.strip

    # Create a new Product object and associate it with the category
    product = category.products.new(
      name: name,
      price: price_in_cents,
      description: description
    )
    product.photo.attach(io: product_image, filename: 'nes.png', content_type: 'image/png')
    product.save!
    puts 'product created'
  end
end
