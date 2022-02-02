module Authenticated
  class AuthenticatedController < ApplicationController
    layout 'authenticated'

    before_action :authenticate_user!

    def authorize_admin
      return if current_user_account.admin?

      return redirect_to(authenticated_root_path)
    end
  end
end