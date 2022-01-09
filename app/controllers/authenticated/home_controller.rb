module Authenticated
  class HomeController < AuthenticatedController
    def index
      @start_date = (Date.parse(params[:start_date] || Date.today.to_s)).beginning_of_week
      @end_date = @start_date.end_of_week
      @week = @start_date..@end_date
      @next_week_start = @start_date + 1.week
      @previous_week_start = @start_date - 1.week
      @home, @office, @onlocation = Location.where(name: %w[office home onlocation]).order(name: :asc)
      @header = [@start_date, @end_date].map { |day| day.strftime("%B %Y") }.uniq.join(' - ')
      @workplaces = current_account.workplaces.includes(:user_accounts)
    end
  end
end