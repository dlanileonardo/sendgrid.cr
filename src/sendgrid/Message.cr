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
      result = JSON.build do |json|
        json.object do
          json.field :personalizations do
            personalizations_serialize(json)
          end

          json.field :from do
            address_serialize(json, from, "from")
          end

          json.field :reply_to do
            address_serialize(json, reply_to, "reply_to")
          end if reply_to

          json.field :subject, subject

          json.field :content, do
            content_serialize(json)
          end
        end
      end
    end

    def to_s : String
      to_json
    end

    private def personalizations_serialize(json)
      json.array do
        json.object do
          json.field :to do
            json.array do
              to.map do |address|
                address_serialize(json, address, "to")
              end
            end
          end
        end
      end
    end

    private def address_serialize(json, target, type : String)
      if to_serialize = target
        json.object do
          json.field :email, to_serialize.email
          json.field :name, to_serialize.name
        end
      else
        raise MessageException.new("Invalid #{type} address")
      end
    end

    private def content_serialize(json)
      if to_serialize = content
        json.array do
          json.object do
            json.field :type, to_serialize.type
            json.field :value, to_serialize.body
          end
        end
      else
        raise MessageException.new("Invalid content")
      end
    end
  end

  class MessageException < Exception
  end
end
