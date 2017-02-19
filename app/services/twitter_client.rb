class TwitterClient
  def initialize
    config = {
      consumer_key:        ENV['CONSUMER_KEY'],
      consumer_secret:     ENV['CONSUMER_SECRET']
    }
    @client = Twitter::REST::Client.new(config)
  end

  def run(tag)
    puts "Connecting to Twitter REST Client ..."
    begin
      @client.search("##{tag}", lang: "en").take(100).collect .each do |tweet|
        print_data(tweet)
        Tweets::Add.call(tweet)
        GraphData.new(tweet).build
      end
    rescue Twitter::Error::TooManyRequests => error
      # NOTE: Your process could go to sleep for up to 15 minutes but if you
      # retry any sooner, it will almost certainly fail with the same exception.
      puts "Twitter::Error::TooManyRequests: #{error.inspect}"
      sleep error.rate_limit.reset_in + 1
      retry
    rescue => error
      puts "Errors .... #{error.inspect}."
      sleep 2
      self.run(tag)
    end
  end

  def print_data(tweet)
    puts
    puts "#{tweet.created_at} : #{tweet.text}"
    puts
  end
end
