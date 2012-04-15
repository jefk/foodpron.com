
require 'twitter'

class TwitterRobot

  def initialize(foodpron_base)
    @foodpron_base = foodpron_base
    @max_id = 0
    @sleep_time = 10
  end

  def go(q)
    puts "starting up the twitter robot"
    while true
      puts "waiting for #{@sleep_time} seconds"
      sleep @sleep_time + rand
      tweets = tweets_since(q, @max_id)
      tweets.sort_by! {|t| t.created_at}
      @max_id = tweets.last.id
      foodpron(tweets)
      @sleep_time = auto_scale(tweets.map {|t| t.created_at})
    end
  end

  private

  def tweets_since(q, max_id)
    tweets = Twitter.search(q, :result_type => 'recent', :since_id => max_id)
    puts "query '#{q}': recieved #{tweets.lenght} tweets"
    tweets
  end

  def foodpron(tweets)
    tweets.each do |tweet|
      urls = extract_urls(tweet.text)
    end
#    tweet.from_user
#    tweet.id
#    tweet.text
#    tweet.created_at
#    puts "#{status.from_user}\t#{status.text}"
  end

  def extract_urls(s)
    s.scan(%r|http://[^\s]*[\w$]|)
  end

  def auto_scale(times)
    # will check again in half time time it took for these tweets to come in
    total_time = Time.now - times.first.created_at
    p total_time
    wait_time = total_time / 2
    bound(wait_time, 10, 100)
  end

  def bound(x, min, max)
    [x, min, max].sort[1]
  end

end
