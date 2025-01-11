class TweetJob < ApplicationJob
  queue_as :default

  def perform(tweet)
    return if tweet.published?

    # Rescheduled a Tweet to the future
    # Tweet isn't published already, but this is a previously scheduled job
    return if tweet.publish_at > Time.current

    tweet.publish_to_twitter!
  end
end
