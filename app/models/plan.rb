class Plan < ApplicationRecord
  has_many :subscriptions
  has_many :accounts, through: :subscriptions

  enum level: { free: 'free', basic: 'basic', pro: 'pro' }
end