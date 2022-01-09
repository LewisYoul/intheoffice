module Authenticated
  class UserAccountsController < AuthenticatedController
    before_action :set_form_variables, only: %i[new edit]

    def index
      @user_accounts = current_account.user_accounts.includes(:user, :role, :workplace)
    end

    def new
      @user_account = UserAccount.new

      render 'new', formats: [:turbo_stream]
    end

    def create
      @user_account = current_account.user_accounts.new(user_account_create_params)

      if @user_account.save
        UserMailer.invite_email(@user_account).deliver_later

        @user_accounts = current_account.user_accounts.includes(:user, :role)
      else
        set_form_variables

        render turbo_stream: turbo_stream.replace(:user_account_invite_form, partial: 'users/invite_form')
      end
    end

    def edit
      @user_account = current_account.user_accounts.find(params[:id])

      render 'edit', formats: [:turbo_stream]
    end

    def update
      @user_account = current_account.user_accounts.find(params[:id])

      unless @user_account.update(user_account_update_params)
        set_form_variables

        render turbo_stream: turbo_stream.replace(:user_account_edit_form, partial: 'authenticated/user_accounts/edit_form')
      end
    end

    def week
      @user_account = current_account.user_accounts.find(params[:id])
      @start_date = (Date.parse(params[:start_date] || Date.today.to_s)).beginning_of_week
      @end_date = @start_date.end_of_week
      @week = @start_date..@end_date
      @next_week_start = @start_date + 1.week
      @previous_week_start = @start_date - 1.week
      @home, @office, @onlocation = Location.where(name: %w[office home onlocation]).order(name: :asc)
      @header = [@start_date, @end_date].map { |day| day.strftime("%B %Y") }.uniq.join(' - ')

      render partial: 'week'
    end

    private

    def set_form_variables
      @roles = Role.all
      @workplaces = current_account.workplaces
    end

    def user_account_update_params
      params.require(:user_account).permit(:role_id, :workplace_id)
    end

    def user_account_create_params
      password = Devise.friendly_token.first(10)

      params.require(:user_account)
        .permit(:role_id, :workplace_id, user_attributes: [:email, :first_name, :last_name])
        .tap do |user_params|
          user_params[:account_id] = current_account.id
          user_params[:user_attributes][:password] = password
          user_params[:user_attributes][:password_confirmation] = password
        end
    end
  end
end