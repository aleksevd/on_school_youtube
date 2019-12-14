if Discipline.count.zero?
  puts 'Seeding Disciplines'

  %w(Графика Скетчинг).each do |name|
    Discipline.create!(name: name)
  end
end