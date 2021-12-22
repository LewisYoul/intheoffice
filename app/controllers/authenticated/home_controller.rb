module Authenticated
  class HomeController < AuthenticatedController
    def index
      @start_date = start_date
      @end_date = end_date
      @home, @office, @onlocation = Location.where(name: %w[office home onlocation]).order(name: :asc)
      @week = date_range
      @user_accounts = current_account.user_accounts.includes(:user, user_account_locations: :location)
      @next_week_start = start_date + 1.week
      @previous_week_start = start_date - 1.week
      @header = [start_date, end_date].map { |day| day.strftime("%B %Y") }.uniq.join(' - ')
    end

    private

    def start_date
      (Date.parse(params[:start_date] || Date.today.to_s)).beginning_of_week
    end

    def end_date
      start_date.end_of_week
    end

    def date_range
      start_date..end_date
    end
  end
end