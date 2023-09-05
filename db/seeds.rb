School.destroy_all
Grade.destroy_all
List.destroy_all
Product.destroy_all
Category.destroy_all
User.destroy_all

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

# products_names = [
#   "Pens (Ballpoint, Gel, Rollerball)",
#   "Pencils (Wooden, Mechanical)",
#   "Notebooks (Spiral, Hardcover, Composition)",
#   "Sticky Notes",
#   "File Folders",
#   "Binders (3-Ring, D-Ring)",
#   "Paper Clips",
#   "Staplers",
#   "Staples (for Staplers)",
#   "Scissors",
#   "Tape (Scotch, Masking, Packing)",
#   "Whiteboards",
#   "Dry Erase Markers",
#   "Calculator",
#   "Desk Organizer",
#   "Calendar (Wall, Desktop)",
#   "Mouse Pad",
#   "Desk Chair",
#   "Desk Lamp",
#   "Shredder",
#   "Envelopes (Various Sizes)",
#   "Highlighters",
#   "Correction Tape/Pens",
#   "Printer Paper",
#   "Printer Ink Cartridges",
#   "Postage Stamps",
#   "Folders with Fasteners",
#   "Paper Shredder",
#   "Desk Calendar",
#   "Push Pins",
#   "Rubber Bands",
#   "Name Badges",
#   "Desk Phone",
#   "Corkboard",
#   "Drawer Organizers",
#   "USB Flash Drive",
#   "Label Maker",
#   "Bulletin Board",
#   "3-Hole Punch",
#   "Desk Mat",
#   "Hole Reinforcements",
#   "Desk Clock",
#   "Letter Opener",
#   "Keyboard Wrist Rest",
#   "Scanner",
#   "Desk Supplies Set",
#   "Desk Plant",
#   "Desk Fan",
#   "Desk Heater",
#   "Desk Phone Stand",
#   "Laptop Stand",
#   "Desk Cable Organizer",
#   "Desktop Computer",
#   "Monitor",
#   "External Hard Drive",
#   "Desk Hutch",
#   "Office Chair Mat",
#   "Drawer Dividers",
#   "Desk Mirror",
#   "Wireless Mouse",
#   "Desk Tray",
#   "Desk Footrest",
#   "Desk Treadmill",
#   "Desk Exercise Equipment"
# ]

# grades_names.each do |grade|
#   products_names.sample(rand(10..15)).each do |name|
#     List.create!(
#       name:,
#       grade:,
#       quantity: rand(1..5),
#       school:
#     )
#     puts 'List created'
#   end
# puts 'creating categories and products'

# 5.times do
#   Category.create(
#     name:
#   )
#   10.times do
#     Product.create!(
#       name:,
#       price:,
#       description:
#     )
#   end
# end


# puts 'category created'

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
