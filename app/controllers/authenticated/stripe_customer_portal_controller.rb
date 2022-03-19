module Authenticated
  class StripeCustomerPortalController < ApplicationController
    def create
      session = Stripe::BillingPortal::Session.create({
        customer: current_account.stripe_customer_id,
        return_url: 'https://c5bf-2a00-23c7-63a9-1c00-1d6d-8286-db00-e283.ngrok.io/account',
      })
    
      redirect_to session.url
    end
  end
end