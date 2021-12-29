module Authenticated
  class HomeController < AuthenticatedController
    before_action :start_date, :end_date

    def index
      @home, @office, @onlocation = Location.where(name: %w[office home onlocation]).order(name: :asc)
      @week = date_range
      @next_week_start = start_date + 1.week
      @previous_week_start = start_date - 1.week
      @user_accounts = current_account.user_accounts.joins(:user).includes(:user, user_account_locations: :location)

      if params[:search]
        @user_accounts = @user_accounts.where("users.full_name ILIKE ?", "%#{params[:search]}%")
      end

      respond_to do |format|
        format.html do
          @header = [start_date, end_date].map { |day| day.strftime("%B %Y") }.uniq.join(' - ')
        end
      end
    end
    
    def search
      @home, @office, @onlocation = Location.where(name: %w[office home onlocation]).order(name: :asc)
      @week = date_range
      @next_week_start = start_date + 1.week
      @previous_week_start = start_date - 1.week
      @user_accounts = current_account.user_accounts.joins(:user).includes(:user, user_account_locations: :location)

      if params[:search].presence
        @user_accounts = @user_accounts.where("users.full_name ILIKE ?", "%#{params[:search]}%")
      end

      respond_to do |format|
        format.turbo_stream
      end
    end

    private

    def start_date
      @start_date ||= (Date.parse(params[:start_date] || Date.today.to_s)).beginning_of_week
    end

    def end_date
      @end_date ||= start_date.end_of_week
    end

    def date_range
      start_date..end_date
    end
  end
end