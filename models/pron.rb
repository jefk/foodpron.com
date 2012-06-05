
class Pron < Sequel::Model

  plugin :timestamps

  one_to_one :image

  def self.current
    self.order(:id).last
  end

end
