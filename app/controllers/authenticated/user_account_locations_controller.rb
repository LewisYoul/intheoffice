module Authenticated
  class UserAccountLocationsController < AuthenticatedController
    def create
      @user_account_location = current_user_account.user_account_locations.new(user_account_location_params)

      @user_account_location.save
    end

    def update
      @user_account_location = current_user_account.user_account_locations.find(params[:id])

      @user_account_location.update(user_account_location_params)

      render :create
    end

    def destroy
      @user_account_location = current_user_account.user_account_locations.find(params[:id])

      @user_account_location.destroy

      render :create
    end

    private

    def user_account_location_params
      params.require(:user_account_location).permit(:location_id, :location_date)
    end
  end
end