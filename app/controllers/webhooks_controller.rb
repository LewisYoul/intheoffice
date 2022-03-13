class WebhooksController < ApplicationController
  protect_from_forgery with: :null_session

  def stripe
    # TODO: authorize
    event = Stripe::Event.construct_from(params.permit!.to_h)

    case event.type
    when "checkout.session.completed"
      puts "\n\n\n SESSION COMPLETE \n\n\n"

      StripeServices::CheckoutSessionCompleter.new(event.data.object).complete
    when "customer.subscription.deleted"
      puts "\n\n\n SUBSCRIPTION CANCELLED \n\n\n"

      StripeServices::SubscriptionCanceller.new(event.data.object).cancel!
    else
      puts "Unhandled event type #{event.type}"
    end
  end
end