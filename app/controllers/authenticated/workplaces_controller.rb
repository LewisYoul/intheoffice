module Authenticated
  class WorkplacesController < AuthenticatedController
    before_action :start_date, :end_date, only: :calendar

    def index
      @workplaces = current_account.workplaces.includes(:user_accounts)
    end

    #don't allow access unless admin
    def new
      @workplace = Workplace.new

      render 'new', formats: [:turbo_stream]
    end

    #don't allow access unless admin
    def create
      @workplace = current_account.workplaces.new(workplace_params)

      if @workplace.save
        @notification_heading = 'Workplace Created'
        @notification_description = 'You can now add members to this workplace'

        render :create
      else
        render turbo_stream: turbo_stream.replace(:workplace_form, partial: 'authenticated/workplaces/form')
      end
    end

    #don't allow access unless admin
    def edit
      @workplace = current_account.workplaces.find(params[:id])
      
      render 'edit', formats: [:turbo_stream]
    end
    
    #don't allow access unless admin
    def update
      @workplace = current_account.workplaces.find(params[:id])

      if @workplace.update(workplace_params)
        @notification_heading = 'Workplace Updated'
        @notification_description = 'You can now add members to this workplace'

        render :create
      else
        render turbo_stream: turbo_stream.replace(:workplace_form, partial: 'authenticated/workplaces/form')
      end
    end

    def destroy
      @workplace = current_account.workplaces.find(params[:id])

      if @workplace.destroy
        @notification_heading = 'Workplace Deleted'
        @notification_description = "You will no longer be able to assign members to this workplace"

        render :create
      else
        render turbo_stream: turbo_stream.replace(:workplace_form, partial: 'authenticated/workplaces/form')
      end
    end

    def calendar
      @workplace = current_account.workplaces.find(params[:id])

      @home, @office, @onlocation = Location.where(name: %w[office home onlocation]).order(name: :asc)
      @week = date_range
      @next_week_start = start_date + 1.week
      @previous_week_start = start_date - 1.week
      @user_accounts = @workplace.user_accounts.joins(:user).includes(:user, user_account_locations: :location)

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
      @workplace = current_account.workplaces.find(params[:id])
      @home, @office, @onlocation = Location.where(name: %w[office home onlocation]).order(name: :asc)
      @week = date_range
      @next_week_start = start_date + 1.week
      @previous_week_start = start_date - 1.week
      @user_accounts = @workplace.user_accounts.joins(:user).includes(:user, user_account_locations: :location)

      if params[:search].presence
        @user_accounts = @user_accounts.where("users.full_name ILIKE ?", "%#{params[:search]}%")
      end

      respond_to do |format|
        format.turbo_stream
      end
    end

    private

    def workplace_params
      params.require(:workplace).permit(:name)
    end

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
