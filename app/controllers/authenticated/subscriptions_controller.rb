module Authenticated
  class SubscriptionsController < AuthenticatedController
    # TODO: only allow admin for current account
    def update
      subscription = current_account.active_subscription
      new_plan = Plan.find(params[:plan_id])
      stripe_sub = Stripe::Subscription.retrieve(subscription.stripe_subscription_id)
      
      Subscription.transaction do
        Stripe::Subscription.update(
          stripe_sub.id,
          items: [
            {
              id: stripe_sub.items.data[0].id,
              price: new_plan.stripe_price_id
            }
          ]
        )

        subscription.update!(plan: new_plan)

        redirect_to(plans_path)
      end
    end

    def cancel
      @subscription = current_account.active_subscription

      raise if @subscription.id.to_s != params[:id]

      # only update our subscription if the request to stripe is successful
      Subscription.transaction do
        Stripe::Subscription.delete(@subscription.stripe_subscription_id)
        @subscription.update!(auto_renew: false)
      end


      redirect_to(account_index_path)
    end
  end
end