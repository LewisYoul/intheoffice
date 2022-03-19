module StripeServices
  class SubscriptionCanceller
    def initialize(stripe_subscription)
      @stripe_subscription = stripe_subscription
    end

    def cancel!
      Subscription.transaction do
        subscription =  Subscription.find_by(stripe_subscription_id: @stripe_subscription.id)

        start_datetime = Time.at(@stripe_subscription.current_period_end)

        subscription.update!(
          plan: Plan.find_by(level: :free),
          auto_renew: true,
          start_datetime: start_datetime,
          end_datetime: 'infinity',
          active: true
        )
      end


      # send an email?
    end
  end
end