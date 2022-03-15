# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # def new
  #   super do |user|
  #     @account = user.accounts.build
  #   end
  # end

  def create
    build_resource(sign_up_params)

    workplace = Workplace.new(name: 'Workplace 1')
    user_account = resource.user_accounts.build(user_account_params.merge(workplace: workplace))
    account = user_account.build_account(account_params)
    workplace.account = account
    now = Time.now
    account.build_subscription(
      plan_id: Plan.find_by(level: :free).id,
      auto_renew: true,
      start_datetime: now,
      end_datetime: 'infinity',
      active: true,
    )

    if resource.save
      UserMailer.with(user: resource).welcome_email.deliver_later

      sign_in(resource)
      set_current_user_account(resource.user_accounts.first)

      redirect_to authenticated_root_path
    else
      render :new
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.

  def user_account_params
    params[:user][:user_accounts_attributes]['0'].permit(:role_id)
  end

  def account_params
    params[:user][:user_accounts_attributes]['0'][:account_attributes].permit(:name)
  end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
