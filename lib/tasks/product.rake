namespace :product do
  desc "Rodar passando URL e CATEGORY desta maneira -> URL=https://www... CATEGORY=... rake product:scrape"
  task scrape: :environment do

    html_file = URI.open(ENV['URL']).read
    html_doc = Nokogiri::HTML(html_file)

    # Find or create a 'pen' category
    category = Category.find_or_create_by(name: ENV['CATEGORY'])

    html_doc.css(".product-item-info").each do |product_info|
      name = product_info.css(".product-item-link").text.strip
      price_str = product_info.css(".price").text.strip

      # Remove "$" symbol, convert to float, multiply by 100, and round to integer
      price_in_cents = (price_str.delete("$").to_f * 100).round

      #  ? image logic not working
      # # Scrape the image URL directly from the HTML
      # image_url_attr = product_info.css(".product.photo.product-item-photo").attr('data-src')

      # # Check if the attribute exists before trying to access its value
      # if image_url_attr
      #   image_url = image_url_attr.value

      #   # Make sure to handle missing images
      #   next if image_url.nil?
      # else
      #   # Handle the case where the attribute is missing
      #   # You can log a message or take appropriate action
      #   # For example:
      #   puts "Image URL attribute not found for product."
      #   next
      # end

      # Extract the URL of the individual product page
      product_page_url = product_info.css(".product-item-link").attr('href').value

      # Make an HTTP request to the individual product page
      product_page_html = URI.open(product_page_url).read
      product_page_doc = Nokogiri::HTML(product_page_html)

      # Scrape the product description from the product page
      description = product_page_doc.css(".value").text.strip

      # Create a new Product object and associate it with the category
      product = category.products.create!(
        name: name,
        price: price_in_cents,
        description: description
      )

      # ? image upload logic not working
      # # Upload the image to Cloudinary and associate it with the 'photo' attribute
      # product.photo.attach(io: URI.open(image_url), filename: "#{product.name.parameterize}-#{product.id}.jpg")
      # product.save
    end
  end
end
