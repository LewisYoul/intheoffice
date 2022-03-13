module Authenticated
  class SubscriptionsController < AuthenticatedController
    # TODO: only allow admin for current account
    def update
      subscription = current_account.subscription
      new_plan = Plan.find(params[:plan_id])

      StripeServices::SubscriptionUpdater.new(subscription, new_plan).update!

      redirect_to(account_index_path)
    end
  end
end