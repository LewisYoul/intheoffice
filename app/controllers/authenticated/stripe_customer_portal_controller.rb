module Authenticated
  class StripeCustomerPortalController < ApplicationController
    def create
      session = Stripe::BillingPortal::Session.create({
        customer: current_account.stripe_customer_id,
        return_url: 'https://d2da-2a00-23c7-63a9-1c00-838-62f2-cecf-f6fe.ngrok.io/account',
      })
    
      redirect_to session.url
    end
  end
end