class UserMailer < ApplicationMailer
  default from: 'info@deskforaday.com'

  def welcome_email
    @user = params[:user]
    @url  = new_user_session_url
    mail(to: @user.email, subject: 'Welcome to DeskForADay')
  end

  def invite_email(user_account)
    @user = user_account.user
    @user_account = user_account
    @account = user_account.account

    raw_reset_password_token, enc_reset_password_token = Devise.token_generator.generate(User, :reset_password_token)

    @user.update!(
      reset_password_token: enc_reset_password_token,
      reset_password_sent_at: Time.now
    )

    @reset_password_url = edit_user_password_url(@user_account.user, reset_password_token: raw_reset_password_token)

    mail(to: @user.email, subject: "You've been invited to InTheOffice")
  end
end
