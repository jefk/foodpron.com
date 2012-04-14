
class Image < Sequel::Model

  plugin :timestamps
  plugin :validation_helpers

  one_to_one :pron

  def validate
    super
    validates_presence [:src]
  end

  def self.increment(src)
    img = self.find_or_create :src => src
    img.score += 1
    img.save

    return img.score
  end

  def self.freshest
    unseen_imgs = self.filter(:pron_id => nil)
    return nil if unseen_imgs.empty?

    unseen_imgs.order(:score.desc).limit(1).first
  end

end
