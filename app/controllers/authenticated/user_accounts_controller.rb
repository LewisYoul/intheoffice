module Authenticated
  class UserAccountsController < AuthenticatedController
    def edit
      @user_account = current_account.user_accounts.find(params[:id])

      render 'edit', formats: [:turbo_stream]
    end

    def update
      @user_account = current_account.user_accounts.find(params[:id])

      @user_account.update(user_account_params)
    end

    private

    def user_account_params
      params.require(:user_account).permit(:role_id)
    end
  end
end