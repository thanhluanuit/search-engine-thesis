namespace :twitter_crawler do
  desc "Crawl data from Twitter by using Twitter Streaming API"
  task run: :environment do
    TwitterCrawler.new.run
  end
end