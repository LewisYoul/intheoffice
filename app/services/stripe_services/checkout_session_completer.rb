module StripeServices
  class CheckoutSessionCompleter
    def initialize(session)
      @session = session
    end

    def complete
      return if session_already_actioned?

      Subscription.transaction do
        account.update!(stripe_customer_id: @session.customer)

        subscription.update!(
          end_datetime: end_datetime,
          plan_id: plan_id,
          auto_renew: true,
          start_datetime: start_datetime,
          end_datetime: end_datetime,
          active: true,
          stripe_subscription_id: stripe_subscription_id
        )
      end
    end

    private

    def session_already_actioned?
      # The session can be completed from PlansController#success
      # or WebhooksController#stripe, whichever is triggered first.
      # Don't do anything if it's already been actioned.
      subscription.stripe_subscription_id == stripe_subscription_id
    end

    def subscription
      @subscription ||= account.subscription
    end

    def stripe_subscription_id
      @session.subscription
    end

    def stripe_subscription
      @stripe_subscription ||= Stripe::Subscription.retrieve(stripe_subscription_id)
    end

    def start_datetime
      @start_datetime ||= Time.at(stripe_subscription.current_period_start)
    end

    def end_datetime
      @end_datetime ||= Time.at(stripe_subscription.current_period_end)
    end

    def plan_id
      @session.metadata.plan_id.to_i
    end

    def account
      @account ||= Account.find(@session.metadata.account_id.to_i)
    end
  end
end