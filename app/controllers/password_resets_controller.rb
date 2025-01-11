class PasswordResetsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])

    if @user.present?
      # Send email
      # PasswordMailer was created with `rails g mailer PasswordMailer`
      # `deliver_later` does the email sending as a background job (non-blocking)
      PasswordMailer.with(user: @user).reset.deliver_later
    end

    redirect_to root_path, notice: "Email sent with password reset instructions."
  end

  def edit
    # Check "rails/globalid" for more information
    @user = User.find_signed!(params[:token], purpose: "password_reset")

  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to password_reset_path, alert: "Your token has expired. Please try again."
  end

  def update
    @user = User.find_signed!(params[:token], purpose: "password_reset")

    if @user.update(password_params)
      redirect_to sign_in_path, notice: "Your password was reset successfully. Please sign in to continue."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
