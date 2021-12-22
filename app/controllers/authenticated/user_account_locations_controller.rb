module Authenticated
  class UserAccountLocationsController < AuthenticatedController
    before_action :set_selectable_locations

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

    def set_selectable_locations
      @home, @office, @onlocation = Location.where(name: %w[office home onlocation]).order(name: :asc)
    end

    def user_account_location_params
      params.require(:user_account_location).permit(:location_id, :location_date)
    end
  end
end