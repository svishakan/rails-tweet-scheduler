class RegistrationsController < ApplicationController
  def new
    @user = User.new # Instance variables are visible to views
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id # Log the user in -- session cookies are encrypted and stored in browser
      redirect_to root_path, notice: "Successfully created account!"
    else
      # Go back to the sign up page
      # Form already handles the error, check the view
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    # More secure way of doing this, use strong parameters, permit only the attributes you want to allow
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
