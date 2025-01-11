class OmniauthCallbacksController < ApplicationController
  before_action :require_user_logged_in!

  def twitter
    Rails.logger.debug auth

    twitter_account = Current.user.twitter_accounts.where(username: auth.info.nickname).first_or_initialize

    twitter_account.update(
      name: auth.info.name,
      image: auth.info.image,
      token: auth.credentials.token,
      secret: auth.credentials.secret
    )

    redirect_to twitter_accounts_path, notice: "Sucessfully connected X account: #{auth.info.nickname}!"
  end
end

def auth
  # Returned from OmniAuth (returns the credentials in a hash)
  request.env["omniauth.auth"]
end
