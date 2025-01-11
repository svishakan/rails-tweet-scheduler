class TwitterAccount < ApplicationRecord
  has_many :tweets, dependent: :destroy # If a TwitterAccount is deleted, delete all associated Tweets
  belongs_to :user

  validates :username, uniqueness: true

  def client
    X::Client.new(
      api_key: Rails.application.credentials.dig(:twitter, :api_key),
      api_key_secret: Rails.application.credentials.dig(:twitter, :api_key_secret),
      access_token: token,
      access_token_secret: secret
    )
  end
end
