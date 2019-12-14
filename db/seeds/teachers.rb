if Teacher.count.zero?
  puts 'Seeding Teachers'
  Teacher.create!(first_name: 'Name', last_name: 'Surname', description: 'Main Teacher')
end
