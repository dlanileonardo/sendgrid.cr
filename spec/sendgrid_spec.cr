require "./spec_helper"

describe Sendgrid do
  describe "#fetch" do
    it "get basic valid json" do
      message = Sendgrid::Message.new
      message.from = Sendgrid::Address.new(email="darthvader@host.com", name="Darth Vader")
      message.reply_to = Sendgrid::Address.new(email="anakinskywalker@starwars.stars", name="Anakin Skywalker")
      message.to << Sendgrid::Address.new(email="lukeskywalker@starwars.stars", name="Luke Skywalker")
      message.subject = "Good News"
      message.content = Sendgrid::Content.new("No, I am your father.")
      extra_fields = {
        "template_id" => "death_star",
        "asm" => {
          "group_id" => "skywalkers",
          "groups_to_display" => "skywalkers"
        } of String => Sendgrid::ExtraFieldsType,
        "attachments" => [
          {
            "content" => "Blue LightSaber",
            "filename" => "blulightsaber.png"
          } of String => Sendgrid::ExtraFieldsType
        ] of Sendgrid::ExtraFieldsType
      } of String => Sendgrid::ExtraFieldsType
      message.extra_fields.merge!(extra_fields)

      message.to_json.should be_a(String)

      object_parse = JSON.parse(message.to_json)

      object_parse["from"]["name"].should eq "Darth Vader"
      object_parse["from"]["email"].should eq "darthvader@host.com"

      object_parse["reply_to"]["name"].should eq "Anakin Skywalker"
      object_parse["reply_to"]["email"].should eq "anakinskywalker@starwars.stars"

      object_parse["personalizations"].size.should eq 1
      object_parse["personalizations"][0]["to"][0]["name"].should eq "Luke Skywalker"
      object_parse["personalizations"][0]["to"][0]["email"].should eq "lukeskywalker@starwars.stars"

      object_parse["content"].size.should eq 1
      object_parse["content"][0]["type"].should eq "text/plain"
      object_parse["content"][0]["value"].should eq "No, I am your father."

      object_parse["subject"].should eq "Good News"
    end
  end
end
