class ApplicationController < ActionController::Base
  helper_method :current_account

  def set_current_account(account)
    session[:current_account_id] = account.id
  end

  def current_account
    @current_account ||= current_user.accounts.find(session[:current_account_id])
  end
end
