module Sendgrid
  class Address
    property email : String
    property name : String?

    def initialize(@email, @name = nil)
      if @email == nil
        raise AddressException.new("Address is nil")
      end
    end
  end

  class AddressException < Exception
  end 
end
