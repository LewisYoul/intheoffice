module Authenticated
  class SubscriptionsController < AuthenticatedController
    # TODO: only allow admin for current account
    def update
      subscription = current_account.active_subscription
      new_plan = Plan.find(params[:plan_id])

      StripeServices::SubscriptionUpdater.new(subscription, new_plan).update!

      redirect_to(plans_path)
    end

    def cancel
      @subscription = current_account.active_subscription

      raise if @subscription.id.to_s != params[:id]

      # only update our subscription if the request to stripe is successful
      Subscription.transaction do
        @subscription.update!(auto_renew: false)
        Stripe::Subscription.delete(@subscription.stripe_subscription_id)
      end


      redirect_to(account_index_path)
    end
  end
end