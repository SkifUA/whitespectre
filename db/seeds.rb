if Category.first.nil?
  user = User.create(name: 'Test Test', email: 'test@email.com')
  Device.create(user_id: user.id)
else
  puts 'Database is not empty'
end
