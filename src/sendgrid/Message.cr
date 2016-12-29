require "json"

module Sendgrid
  class Message
    property from : Address?
    property reply_to : Address?
    property to : Array(Address)
    property subject : String?
    property content : Content?
    property extra_fields : ExtraFields

    def initialize
      @to = Array(Sendgrid::Address).new
      @extra_fields = ExtraFields.new
    end

    def to_json : String
      result = String.build do |io|
        JSON::PrettyWriter.new(io, indent: "  ").json_object do |object|
          object.field :personalizations, personalizations_serialize
          object.field :from, address_serialize(from, "from")
          object.field :reply_to, address_serialize(reply_to, "reply_to") if reply_to
          object.field :subject, subject
          object.field :content, content_serialize
          extra_fields.each do |key, field|
            object.field key, field
          end
        end
      end
    end

    def to_s : String
      to_json
    end

    private def personalizations_serialize
      [{
        to: to.map do |address| 
              address_serialize(address, "to")
            end
      }]
    end

    private def address_serialize(target, type : String)
      if to_serialize = target
        {
          email: to_serialize.email,
          name: to_serialize.name
        }
      else
        raise MessageException.new("Invalid #{type} address")
      end
    end

    private def content_serialize
      if to_serialize = content
        [{
          type: to_serialize.type,
          value: to_serialize.body
        }]
      else
        raise MessageException.new("Invalid content")
      end
    end
  end

  class MessageException < Exception
  end
end
