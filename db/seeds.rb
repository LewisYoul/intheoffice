# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Role.names.keys.each { |name| Role.create!(name: name) }

user_attrs = {
  first_name: 'Joe',
  last_name: 'Bloggs',
  email: 'testuser@gmail.com',
  password: 'testpassword1!',
  password_confirmation: 'testpassword1!',
  user_accounts_attributes: [
    {
      role_id: Role.find_by_name('admin').id,
      account_attributes: {
        name: 'Test Account 1'
      }
    }
  ]
}

User.create(user_attrs)