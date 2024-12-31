class RegistrationsController < ApplicationController
  def new
    @user = User.new # Instance variables are visible to views
  end
end
