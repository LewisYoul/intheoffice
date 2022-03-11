class Account < ApplicationRecord
  has_many :subscriptions
  has_one :active_subscription, -> { where(active: true) }, class_name: 'Subscription'
  has_one :plan, through: :active_subscription
  has_many :user_accounts
  has_many :users, through: :user_accounts
  has_many :roles, through: :user_accounts
  has_many :user_account_locations, through: :user_accounts
  has_many :workplaces

  accepts_nested_attributes_for :workplaces
  accepts_nested_attributes_for :subscriptions

  validates_presence_of :name
  validate :has_one_active_subscription

  private

  def has_one_active_subscription
    return if (persisted? && subscriptions.where(active: true).size == 1) || (!persisted? && subscriptions.select(&:active).size == 1)

    # unless they are basic?
    errors.add(:active_subscription, message: 'accounts must always have one active subscription')
  end
end
