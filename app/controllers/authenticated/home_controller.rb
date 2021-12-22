module Authenticated
  class HomeController < AuthenticatedController
    def index
      @today = Date.today
      @current_week = @today.beginning_of_week..@today.end_of_week

      @home, @office, @onlocation = Location.where(name: %w[office home onlocation]).order(name: :asc)

      @user_accounts = current_account.user_accounts
        .includes(:user)
        .left_joins(:user_account_locations)
        .where("user_account_locations.location_date BETWEEN ? AND ? OR user_account_locations.location_date IS NULL", @current_week.first, @current_week.last)
        .distinct
    end
  end
end