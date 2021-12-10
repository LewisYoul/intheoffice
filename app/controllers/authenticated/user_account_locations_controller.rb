module Authenticated
  class UserAccountLocationsController < AuthenticatedController
    def create
      @user_account = current_account.user_accounts.find(params[:user_account_id])

      @user_account_location = @user_account.user_account_locations.new(user_account_location_params)

      @user_account_location.save
    end

    private

    def user_account_location_params
      params.require(:user_account_location).permit(:location_id, :location_date)
    end
  end
end