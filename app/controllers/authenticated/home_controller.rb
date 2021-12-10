module Authenticated
  class HomeController < AuthenticatedController
    def index
      @today = Date.today
      @current_week = @today.beginning_of_week..@today.end_of_week
      @user_accounts = current_account.user_accounts.includes(:user)
    end
  end
end