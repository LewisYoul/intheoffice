module Authenticated
  class UsersController < AuthenticatedController
    def index
      @user_accounts = current_account.user_accounts.includes(:user, :role)
    end
    
    def edit
      @user = User.find(params[:user_id])

    end
    
    def new
      @user = User.new

      render 'new', formats: [:turbo_stream]
    end

    def invite
      @user = User.new(user_params)
      @hidden = false

      if @user.save
        @users = current_account.users
        @user = User.new
        @hidden = true
      end
    end

    def user_params
      password = Devise.friendly_token.first(10)

      params.require(:user).permit(:first_name, :last_name, :email, user_accounts_attributes: [:account_id, :role_id])
        .tap do |params|
          params[:password] = password
        end
    end
  end
end