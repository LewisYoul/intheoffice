class Plan < ApplicationRecord
  has_many :subscriptions
  has_many :accounts, through: :subscriptions

  enum level: { free: 'free', basic: 'basic', pro: 'pro' }

  def >(comparison_plan)
    order = Plan.levels.values

    order.index(level) > order.index(comparison_plan.level)
  end

  def paid?
    !free?
  end
end