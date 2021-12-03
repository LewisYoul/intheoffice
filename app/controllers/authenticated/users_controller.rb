module Authenticated
  class UsersController < AuthenticatedController
    def index
      @users = current_account.users
    end
  end
end