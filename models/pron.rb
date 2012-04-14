
class Pron < Sequel::Model

  plugin :timestamps

  one_to_one :image

  def self.current
    self[ self.max(:id) ]
  end

end
