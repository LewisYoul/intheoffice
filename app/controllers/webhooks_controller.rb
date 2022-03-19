class WebhooksController < ApplicationController
  protect_from_forgery with: :null_session

  def stripe
    # TODO: authorize
    event = Stripe::Event.construct_from(params.permit!.to_h)

    case event.type
    when "checkout.session.completed"
      puts "\n\n\n SESSION COMPLETE \n\n\n"

      StripeServices::CheckoutSessionCompleter.new(event.data.object).complete
    when 'customer.subscription.updated'
      puts "\n\n\n SUBSCRIPTION UPDATED \n\n\n"

      stripe_subscription = event.data.object
      stripe_price = stripe_subscription.items.data[0].price

      subscription = Subscription.find_by!(stripe_subscription_id: stripe_subscription.id)
      plan = Plan.find_by!(stripe_price_id: stripe_price.id)

      auto_renew = !stripe_subscription.cancel_at_period_end

      subscription.update!(plan: plan, auto_renew: auto_renew)
      # extract to service
      # send an email?
    when "customer.subscription.deleted"
      puts "\n\n\n SUBSCRIPTION CANCELLED \n\n\n"

      StripeServices::SubscriptionCanceller.new(event.data.object).cancel!
    else
      puts "Unhandled event type #{event.type}"
    end
  end
end