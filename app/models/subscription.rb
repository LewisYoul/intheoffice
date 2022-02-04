class Subscription < ApplicationRecord
  belongs_to :account
  belongs_to :plan

  validates_presence_of :stripe_subscription_id, if: -> { !plan.free? }
end