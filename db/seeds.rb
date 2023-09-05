List.destroy_all
Grade.destroy_all
School.destroy_all
User.destroy_all
Category.destroy_all
Product.destroy_all

puts 'Starting seed'

# Create schools
10.times do
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
    puts "Grade created: #{grade.name}"

    # Create lists for each grade
    5.times do
      List.create!(
        name: "Material List for #{grade.name}",
        grade: grade,
        quantity: rand(1..5)
      )
    end
    puts "Lists created for #{grade.name}"
  end
end

# Create 6 categories
6.times do
  category = Category.create!(
    name: Faker::Commerce.unique.department(max: 1)
  )
  # Create products for each category
  10.times do
    product = Product.create!(
      name: Faker::Commerce.product_name,
      description: Faker::Lorem.sentence,
      price: rand(10..50),
      category:
    )
  end
end

puts 'generating users'

user = User.create(
  email: 'test@gmail.com',
  password: '123123',
  first_name: Faker::Name.name,
  last_name: Faker::Name.last_name,
  phone: Faker::PhoneNumber.cell_phone,
  address: Faker::Address.street_address
)

10.times do
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
