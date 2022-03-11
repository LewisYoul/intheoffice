module Authenticated
  class AccountController < AuthenticatedController
    def index
      @subscription = current_account.active_subscription
      @cancel_text
    end
  end
end