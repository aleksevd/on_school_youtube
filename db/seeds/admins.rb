if Admin.count.zero?
  puts 'Seeding Admins'
  Admin.create!(email: 'john@dow.com', first_name: 'John', last_name: 'Doe', password: '123123', password_confirmation: '123123')
end
