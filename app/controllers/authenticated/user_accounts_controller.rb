module Authenticated
  class UserAccountsController < AuthenticatedController
    before_action :set_form_variables, only: %i[new edit]

    def index
      @user_accounts = current_account.user_accounts.includes(:user, :role)
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