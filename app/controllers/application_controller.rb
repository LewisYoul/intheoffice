class ApplicationController < ActionController::Base
  helper_method :current_user_account
  helper_method :current_account
  helper_method :current_role

  def set_current_user_account(user_account)
    session[:current_user_account_id] = user_account.id
  end

  def current_user_account
    @current_user_account ||= current_user.user_accounts.find(session[:current_user_account_id])
  end

  def current_role
    @current_role ||= current_user_account.role
  end

  def current_account
    @current_account ||= current_user.accounts.find(current_user_account.account_id)
  end
end
