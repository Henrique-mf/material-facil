CartItem.destroy_all
Cart.destroy_all
Order.destroy_all
ListProduct.destroy_all
List.destroy_all
Grade.destroy_all
School.destroy_all
Product.destroy_all
Category.destroy_all
User.destroy_all


puts 'Starting seed'

puts 'generating users'

user = User.create(
  email: 'admin@gmail.com',
  password: '123123',
  first_name: Faker::Name.name,
  last_name: Faker::Name.last_name,
  phone: Faker::PhoneNumber.cell_phone,
  address: Faker::Address.street_address,
  admin: true
)
puts 'admin generated'

user = User.create(
  email: 'client@gmail.com',
  password: '123123',
  first_name: Faker::Name.name,
  last_name: Faker::Name.last_name,
  phone: Faker::PhoneNumber.cell_phone,
  address: Faker::Address.street_address,
  admin: false
)
puts 'client generated'

scrape_data = [
  { url: 'https://www.papersource.com/desk/writing-instruments/pens', category: 'Pens' },
  { url: 'https://www.papersource.com/craft/paper-bar/paper', category: 'Paper' },
  { url: 'https://www.papersource.com/craft/paper-bar/envelopes', category: 'Envelopes' },
  { url: 'https://www.papersource.com/craft/tools/tape', category: 'Tape' }
]

scrape_data.each do |data|
  html_file = URI.open(data[:url]).read
  html_doc = Nokogiri::HTML(html_file)

  # Find or create a 'pen' category
  category = Category.find_or_create_by(name: data[:category])

  html_doc.css(".product-item-info").take(5).each do |product_info|
    name = product_info.css(".product-item-link").text.strip
    price_str = product_info.css(".price").text.strip.gsub('.', '').delete("$")
    p price_str
    # Remove "$" symbol, convert to float, multiply by 100, and round to integer
    price_in_cents = (price_str.to_f / 100)

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
    p product
    puts 'product created'
  end
end
# Create schools
5.times do
school = School.create!(
    name: Faker::University.name
  )
  puts "School created: #{school.name}"

  # Create grades for each school
  (1..12).each do |grade_number|
    grade = Grade.create!(
      name: "#{grade_number.ordinalize} Grade",
      school: school
    )
    list = List.create!(
      name: "List for #{grade.name}, from #{school.name}",
      grade: grade
    )
    Category.all.each do |category|
      category.products.sample(rand(2..5)).each do |product|
        ListProduct.create!(
          list: list,
          product: product,
          quantity: rand(1..5)
        )
      end
    end
  end
end


puts 'seed succesfull'
