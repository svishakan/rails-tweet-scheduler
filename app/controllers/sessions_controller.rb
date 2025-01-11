class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])

    # `authenticate` comes from `has_secure_password` in the User model
    if @user.present? && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Logged in successfully!"
    else
      flash[:alert] = "Invalid email or password"
      render :new, status: :unauthorized
    end
  end

  def destroy
    # Clear the session cookie
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out!"
  end
end
