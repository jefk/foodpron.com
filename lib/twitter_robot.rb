
require 'twitter'
require_relative 'image_extractor'
require_relative 'foodpron_client'

class TwitterRobot

  def initialize(foodpron_base)
    @foodpron_base = foodpron_base
    @max_id = 0
    @sleep_time = 10
  end

  def go(q)
    puts "starting up the twitter robot"
    while true
      puts "waiting #{@sleep_time} seconds"
      sleep @sleep_time + rand
      tweets = tweets_since(q, @max_id)
      next if tweets.empty?

      tweets.sort_by! { |t| t.created_at }
      tweets.each { |tweet| tweet_to_image(tweet) }
      @max_id = tweets.last.id
      @sleep_time = auto_scale(tweets.map {|t| t.created_at})
    end
  end

  private

  attr_accessor :foodpron_base

  def tweets_since(q, max_id)
    tweets = Twitter.search(q, :result_type => 'recent', :since_id => max_id)
    puts "query '#{q}': recieved #{tweets.length} tweets"
    tweets
  end

  def tweet_to_image(tweet)
#    tweet.from_user
#    tweet.id
#    tweet.text
#    tweet.created_at
    urls = extract_urls(tweet.text)
    puts tweet.text
    puts urls.inspect

    urls.each do |url|
      img_src = begin
        ImageExtractor.largest_image(url)
      rescue
        next
      end
      next unless img_src

      puts "posting #{img_src} to foodpron"
      foodpron.post_image(img_src)
    end
  end

  def extract_urls(s)
    s.scan(%r|http://[^\s]*[\w$]|)
  end

  def auto_scale(times)
    # will check again in the time it usually takes to get 8 tweets
    # avg_time is laplace smooth'd
    avg_time = (times.last - times.first + 10) / times.length
    time_str = "%0.1f" % avg_time
    puts "#{time_str} seconds per tweet"
    wait_time = 8*avg_time
    bound(wait_time, 10, 100)
  end

  def foodpron
    @foodpron ||= FoodpronClient.new foodpron_base
  end

  def bound(x, min, max)
    [x, min, max].sort[1]
  end

end

if $PROGRAM_NAME == __FILE__
  puts "usage: ruby twitter_robot.rb [query]"
  exit if ARGV.first.nil?
  query = ARGV.first.strip
  exit if query.empty?

  robot = TwitterRobot.new 'localhost:4567'
  while true
    begin
      robot.go query
    end
  end

end
