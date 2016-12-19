module Sendgrid
  class Content
    property body : String
    property type : String

    def initialize(@body, @type = "text/plain")
      if body == nil
        raise AddressException.new("Content is nil")
      end
    end
  end

  class ContentException < Exception
  end
end
