module Authenticated
  class SubscriptionsController < AuthenticatedController
    def cancel
      @subscription = current_account.active_subscription

      raise if @subscription.id.to_s != params[:id]

      Stripe::Subscription.delete(@subscription.stripe_subscription_id)

      @subscription.update!(auto_renew: false)

      redirect_to(account_index_path)
    end
  end
end