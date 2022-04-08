module Authenticated
  class AccountController < AuthenticatedController
    def index
      @subscription = current_account.subscription
      @plans = Plan.order(monthly_cost_dollars: :asc)
    end
  end
end