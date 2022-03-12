module Authenticated
  class PlansController < AuthenticatedController
    before_action :authorize_admin

    def index
      @plans = Plan.order(monthly_cost_dollars: :asc)
    end

    def upgrade
      redirect_to(authenticated_root_path) if current_account.plan.pro?

      @plan = Plan.find(params[:id])

      session = Stripe::Checkout::Session.create(
        success_url: 'https://1c5b-2a00-23c7-63a9-1c00-4580-2087-6e4a-9c0d.ngrok.io/plans/success?session_id={CHECKOUT_SESSION_ID}',
        cancel_url: 'https://1c5b-2a00-23c7-63a9-1c00-4580-2087-6e4a-9c0d.ngrok.io/plans',
        mode: 'subscription',
        metadata: { account_id: current_account.id, plan_id: @plan.id },
        line_items: [{ quantity: 1, price: @plan.stripe_price_id }]
      )

      redirect_to session.url
    end

    def success
      return redirect_to(authenticated_root_path) unless params[:session_id]

      session = Stripe::Checkout::Session.retrieve(params[:session_id])

      puts "\n\n\n SUCCESS \n\n\n"

      StripeServices::CheckoutSessionCompleter.new(session).complete
    end
  end
end