module Authenticated
  class AccountController < AuthenticatedController
    def index
      @subscription = current_account.subscription
      @plans = Plan.order(monthly_cost_dollars: :asc)
      @summary_text = summary_text
    end

    private

    # TODO: extract to helper
    def summary_text
      text = "Your account is on the #{current_account.plan.level.capitalize} plan."

      return text if current_account.plan.free?

      if current_account.subscription.auto_renew?
        text << " Your subscription will renew on #{current_account.subscription.end_datetime.strftime('%d %m %y')}."
      else
        text << " Your subscription has been set to cancel on #{current_account.subscription.end_datetime.strftime('%d %m %y')}. At which point you will be reverted to our free plan."
      end

      text
    end
  end
end