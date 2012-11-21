
class Image

  def validate
    super
    validates_presence [:src]
  end

  def self.increment(src)
    redis.zincrby(set_key, 1, src)
  end

  def self.freshest
    redis.zrange(set_key, -1, -1).first
  end

  def self.make_pron(src)
    redis.zrem(set_key, src)
    redis.set(pron_key, src)
  end

  def self.pron
    redis.get(pron_key)
  end

  def self.all
    redis.zrange(set_key, 0, -1, with_scores: true)
  end

  private

  def self.set_key
    'ranked-images'
  end

  def self.pron_key
    'pron'
  end

  def self.redis
    if ENV['REDISTOGO_URL'].nil?
      @@redis ||= Redis.new
    else
      uri = URI.parse(ENV['REDISTOGO_URL'])
      @@redis ||= Redis.new(host: uri.host, port: uri.port, password: uri.password)
    end
  end

end
