class TwitterCrawler
  SCOPE_FILTER = { language: "en", locations: "-180,-90,180,90" }

  def initialize
    config = {
      consumer_key:        ENV['CONSUMER_KEY'],
      consumer_secret:     ENV['CONSUMER_SECRET'],
      access_token:        ENV['ACCESS_TOKEN'],
      access_token_secret: ENV['ACCESS_TOKEN_SECRET']
    }
    @client = Twitter::Streaming::Client.new(config)
  end

  def run
    puts "Connecting to Twitter Streaming Client ..."
    begin
      @client.filter(SCOPE_FILTER) do |tweet|
        print_data(tweet)
        Tweets::Add.call(tweet)
        GraphData.new(tweet).build
      end
    rescue Twitter::Error::TooManyRequests => error
      # NOTE: Your process could go to sleep for up to 15 minutes but if you
      # retry any sooner, it will almost certainly fail with the same exception.
      puts "Twitter::Error::TooManyRequests: #{error.inspect}"
      sleep 2
      retry
    rescue => error
      puts "Errors .... #{error.inspect}."
      sleep 2
      self.run
    end
  end

  def print_data(tweet)
    puts
    puts "#{tweet.created_at} : #{tweet.text}"
    puts
  end
end
