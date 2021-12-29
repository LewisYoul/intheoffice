module Authenticated
  class UserAccountLocationsController < AuthenticatedController
    before_action :set_selectable_locations

    def new
      @user_account_location = current_user_account.user_account_locations.new(location_date: params[:location_date])
      @panel_header = @user_account_location.location_date.strftime("%A #{@user_account_location.location_date.day.ordinalize} %B")
      @method = :post

      render layout: false
    end

    def edit
      @user_account_location = current_user_account.user_account_locations.find(params[:id])
      @panel_header = @user_account_location.location_date.strftime("%A #{@user_account_location.location_date.day.ordinalize} %B")
      @method = :put

      render layout: false
    end

    def create
      @user_account_location = current_user_account.user_account_locations.new(user_account_location_params)

      @user_account_location.save
      @notification_heading = 'Location Updated!'
      @notification_description = "You'll be #{@user_account_location.location.name} on #{@user_account_location.location_date.strftime('%A %-d %B')}"
    end

    def update
      @user_account_location = current_user_account.user_account_locations.find(params[:id])

      @user_account_location.update(user_account_location_params)
      @notification_heading = 'Location Updated!'
      @notification_description = "You'll be #{@user_account_location.location.name} on #{@user_account_location.location_date.strftime('%A %-d %B')}"

      render :create
    end

    def destroy
      @user_account_location = current_user_account.user_account_locations.find(params[:id])

      @user_account_location.destroy
      @notification_heading = 'Location Updated!'
      @notification_description = "You've unset your location for #{@user_account_location.location_date.strftime('%A %-d %B')}"

      render :create
    end

    private

    def set_selectable_locations
      @home, @office, @onlocation = Location.where(name: %w[office home onlocation]).order(name: :asc)
    end

    def user_account_location_params
      params.require(:user_account_location).permit(:location_id, :location_date, :note).tap { |p| p[:note] = p[:note].presence }
    end
  end
end