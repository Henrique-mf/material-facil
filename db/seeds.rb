OrderProduct.destroy_all
Cart.destroy_all
Order.destroy_all
User.destroy_all
ListProduct.destroy_all
List.destroy_all
Grade.destroy_all
School.destroy_all

puts 'Starting seed'

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

puts 'generating users'

user = User.create(
  email: 'admin@gmail.com',
  password: '123123',
  first_name: Faker::Name.name,
  last_name: Faker::Name.last_name,
  phone: Faker::PhoneNumber.cell_phone,
  address: Faker::Address.street_address
)

3.times do
  user = User.create(
    first_name: Faker::Name.name,
    last_name: Faker::Name.last_name,
    phone: Faker::PhoneNumber.cell_phone,
    email: Faker::Internet.email,
    address: Faker::Address.street_address
  )
  puts 'user generated'
end

puts 'seed succesfull'
