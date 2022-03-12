class WebhooksController < ApplicationController
  protect_from_forgery with: :null_session

  def stripe
    # TODO: authorize
    event = Stripe::Event.construct_from(params.permit!.to_h)

    case event.type
    when "checkout.session.completed"
      puts "\n\n\n SESSION COMPLETE \n\n\n"

      StripeServices::CheckoutSessionCompleter.new(event.data.object).complete
    else
      puts "Unhandled event type #{event.type}"
    end
  end
end