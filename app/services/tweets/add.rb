module Tweets
  class Add
    class << self
      def call(tweet)
        Tweet.create(
          uri:          tweet.uri,
          text:         tweet.text,
          user_name:    tweet.user.name,
          url:          tweet.urls.first.try(:url),
          display_url:  tweet.urls.first.try(:display_url),
          expanded_url: tweet.urls.first.try(:expanded_url),
          geo:          tweet.geo,
          lang:         tweet.lang,
          source:       tweet.source,
          tweet_created_at:  tweet.created_at,
          original_tweet_id: tweet.id
        )
      end
    end
  end
end
