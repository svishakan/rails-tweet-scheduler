class TweetsController < ApplicationController
  before_action :require_user_logged_in!
  before_action :set_tweet, only: [ :show, :edit, :update, :destroy ]

  def index
    @tweets = Current.user.tweets
  end

  def new
    @tweet = Tweet.new
  end

  def show
  end

  def create
    @tweet = Current.user.tweets.new(tweet_params)

    print "Tweet: #{@tweet}, hello!"

    if @tweet.save
      redirect_to tweets_path, notice: "Tweet was scheduled successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @tweet.update(tweet_params)
      redirect_to tweets_path, notice: "Tweet was updated successfully!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @tweet.destroy

    redirect_to tweets_path, notice: "Tweet was unscheduled successfully!"
  end

  private

  def tweet_params
    params.require(:tweet).permit(:twitter_account_id, :body, :publish_at)
  end

  def set_tweet
    @tweet = Current.user.tweets.find(params[:id])
  end
end
