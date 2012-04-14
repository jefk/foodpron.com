
class ImageSource < Sequel::Model

  plugin :timestamps
  plugin :validation_helpers

  def validate
    super
    validates_presence [:img_src]
  end

end
