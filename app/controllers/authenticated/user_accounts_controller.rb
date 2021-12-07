module Authenticated
  class UserAccountsController < AuthenticatedController
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
        @user_accounts = current_account.user_accounts.includes(:user, :role)
      end
    end

    def edit
      @user_account = current_account.user_accounts.find(params[:id])

      render 'edit', formats: [:turbo_stream]
    end

    def update
      @user_account = current_account.user_accounts.find(params[:id])

      @user_account.update(user_account_update_params)
    end

    private

    def user_account_update_params
      params.require(:user_account).permit(:role_id)
    end

    def user_account_create_params
      password = Devise.friendly_token.first(10)

      params.require(:user_account)
        .permit(:role_id, user_attributes: [:email, :first_name, :last_name])
        .tap do |ps|
          ps[:user_attributes][:password] = password
          ps[:user_attributes][:password_confirmation] = password
        end
    end
  end
end