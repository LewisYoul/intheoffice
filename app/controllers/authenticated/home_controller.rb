module Authenticated
  class HomeController < AuthenticatedController
    def index
      @workplaces = current_account.workplaces.includes(:user_accounts)
    end
  end
end