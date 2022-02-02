class Account < ApplicationRecord
  has_many :subscriptions
  has_one :active_subscription, -> { where('start_date <= :today AND end_date >= :today', today: Date.today) }, class_name: 'Subscription'
  has_one :plan, through: :active_subscription
  has_many :user_accounts
  has_many :users, through: :user_accounts
  has_many :roles, through: :user_accounts
  has_many :user_account_locations, through: :user_accounts
  has_many :workplaces

  accepts_nested_attributes_for :workplaces

  validates_presence_of :name
  validate :has_active_subscription

  private

  def has_active_subscription
    return if active_subscription

    # unless they are basic?
    errors.add(:active_subscription, message: 'accounts must always have an active subscription')
  end
end
