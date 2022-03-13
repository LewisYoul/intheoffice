module StripeServices
  class SubscriptionUpdater
    def initialize(subscription, new_plan)
      @subscription = subscription
      @new_plan = new_plan
    end

    def update!
      return if current_plan == @new_plan
      
      @new_plan.free? ? cancel_subscription : update_subscription
    end

    private

    def current_plan
      @subscription.plan
    end

    def stripe_subscription
      @stripe_subscription ||= Stripe::Subscription.retrieve(@subscription.stripe_subscription_id)
    end

    # Cancel the subscription in stripe so that the account still
    # has access until their subscription expires.
    # The daily job will then revert the plan to 'free'.
    def cancel_subscription
      Subscription.transaction do
        @subscription.update!(auto_renew: false)

        Stripe::Subscription.update(
          stripe_subscription.id,
          cancel_at_period_end: true
        )
      end
    end

    # Update the existing subscription with the new price id in stripe.
    # Stripe will automatically pro-rata the invoice and charge the correct
    # amount when the new payment is taken.
    def update_subscription
      Subscription.transaction do
        @subscription.update!(plan: @new_plan, auto_renew: true)
        
        Stripe::Subscription.update(
          stripe_subscription.id,
          cancel_at_period_end: false,
          items: [
            {
              id: stripe_subscription.items.data[0].id,
              price: @new_plan.stripe_price_id
            }
          ]
        )
      end
    end
  end
end