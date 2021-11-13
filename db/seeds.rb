# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user_attrs = {
  email: 'testuser@gmail.com',
  password: 'testpassword1!',
  password_confirmation: 'testpassword1!',
}

user = User.create!(user_attrs)
account = Account.create!(user: user)

participants = [
  {
    first_name: 'Elon',
    last_name: 'Musk',
    email: 'elon@gmail.com',
    user: user,
    account: account
  },
  {
    first_name: 'Richard',
    last_name: 'Branson',
    email: 'richard@gmail.com',
    user: user,
    account: account
  },
  {
    first_name: 'Jeff',
    last_name: 'Bezos',
    email: 'jeff@gmail.com',
    user: user,
    account: account
  },
]

participants.each { |participant| Participant.create!(participant) }