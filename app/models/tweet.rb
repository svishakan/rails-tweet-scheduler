class Tweet < ApplicationRecord
  belongs_to :user
  belongs_to :twitter_account

  validates :body, presence: true, length: { minimum: 1, maximum: 280 }
  validates :publish_at, presence: true

  after_initialize do
    # Called after the Tweet is initialized, sets a default publish_at value
    self.publish_at ||= 1.hour.from_now
  end

  after_save_commit do
    # Happens after the Tweet is saved to the database
    if publish_at_previously_changed?
      # If the publish_at attribute has changed, enqueue a TweetJob
      TweetJob.set(wait_until: publish_at).perform_later(self)
    end
  end

  def published?
    # Rails model helper, returns true if tweet_id in the record has been set
    # We set tweet_id when the Tweet is published
    tweet_id?
  end

  def publish_to_twitter!
    tweet = twitter_account.client.post("tweets", { text: body }.to_json)
    Rails.logger.debug("Published to Twitter: #{tweet}")
    update(tweet_id: tweet.dig("data", "id"))
  end
end
