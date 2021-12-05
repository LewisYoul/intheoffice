module Authenticated
  class UsersController < AuthenticatedController
    def index
      @users = current_account.users
      @user = User.new
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

      params.require(:user).permit(:first_name, :last_name, :email)
        .tap do |params|
          params[:account_ids] = [current_account.id]
          params[:password] = password
        end
    end
  end
end