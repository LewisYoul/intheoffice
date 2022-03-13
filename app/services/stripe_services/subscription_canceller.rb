module StripeServices
  class SubscriptionCanceller
    def initialize(stripe_subscription)
      @stripe_subscription = stripe_subscription
    end

    def cancel!
      Subscription.transaction do
        subscription =  Subscription.find_by(active: true, stripe_subscription_id: @stripe_subscription.id)
        account = subscription.account

        start_datetime = Time.at(@stripe_subscription.current_period_end)

        subscription.update!(active: false, end_datetime: start_datetime)

        account.subscriptions.create!(
          plan: Plan.find_by(level: :free),
          auto_renew: false,
          start_datetime: start_datetime,
          end_datetime: start_datetime + 1.month,
          active: true,
        )
      end
    end
  end
end