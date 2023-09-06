List.destroy_all
Grade.destroy_all
School.destroy_all
User.destroy_all
Product.destroy_all
Category.destroy_all

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

    # Create lists for each grad
      rand(10..15).times do
        List.create!(
          name: Faker::Commerce.product_name,
          grade: grade,
          quantity: rand(1..5)
        )
      end
      puts "List created for #{grade.name}"
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
