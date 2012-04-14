
class ImageSource < Sequel::Model

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
  end

end
