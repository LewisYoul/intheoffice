# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

plans = [
  {
    level: :free,
    monthly_cost_dollars: 0,
    yearly_cost_dollars: 0,
    stripe_price_id: 'price_1KPUPhGlxSCwqUdEOcBvWtqs'
  },
  {
    level: :basic,
    monthly_cost_dollars: 20,
    yearly_cost_dollars: 200,
    stripe_price_id: 'price_1KPUJkGlxSCwqUdE74hFl0nX'
  },
  {
    level: :pro,
    monthly_cost_dollars: 40,
    yearly_cost_dollars: 400,
    stripe_price_id: 'price_1KPUKNGlxSCwqUdElZjJbgVZ'
  }
]

plans.each { |plan| Plan.create!(plan) }

Role.names.keys.each { |name| Role.create!(name: name) }
Location.names.keys.each { |name| Location.create!(name: name) }

account = Account.create!(
  name: 'Test Account 1',
  subscription_attributes: {
    plan: Plan.find_by_level(:free),
    start_datetime: Time.zone.now,
    end_datetime: 'infinity',
    auto_renew: true,
    active: true
  }
)
workplace = Workplace.create!(name: 'Workplace 1', account: account)

user_attrs = {
  first_name: 'Joe',
  last_name: 'Bloggs',
  email: 'testuser@gmail.com',
  password: 'testpassword1!',
  password_confirmation: 'testpassword1!',
  user_accounts_attributes: [
    {
      role_id: Role.find_by_name('Admin').id,
      account_id: account.id,
      workplace_id: workplace.id
    }
  ]
}

User.create!(user_attrs)