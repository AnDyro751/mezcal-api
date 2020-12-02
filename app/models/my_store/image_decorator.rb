module ImageDecorator

  def self.prepended(base)
    base.attachment_definitions[:attachment][:styles] = {
        large: '1500x1500>'
    }
    base.attachment_definitions[:attachment][:path] = ":id/:style/:basename.:extension"

  end

  Spree::Image.prepend self
end