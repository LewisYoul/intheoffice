module Authenticated
  class HomeController < AuthenticatedController
    def index
      @week = date_range
      @home, @office, @onlocation = Location.where(name: %w[office home onlocation]).order(name: :asc)
      @workplaces = current_account.workplaces.includes(:user_accounts)
    end

    private

    def start_date
      @start_date ||= Date.today.beginning_of_week
    end

    def end_date
      @end_date ||= start_date.end_of_week
    end

    def date_range
      start_date..end_date
    end
  end
end