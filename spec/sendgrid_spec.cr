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

      object_parse = JSON.parse(message.to_json)
      message.to_json.should be_a(String)
      
      object_parse.should contain("personalizations")
      
      object_parse["personalizations"][0].should contain("to")
      object_parse["personalizations"][0]["to"][0].should contain("email")
      object_parse["personalizations"][0]["to"][0].should contain("name")

      object_parse.should contain("from")
      object_parse["from"].should contain("email")
      object_parse["from"].should contain("name")

      object_parse.should contain("reply_to")
      object_parse["reply_to"].should contain("email")
      object_parse["reply_to"].should contain("name")

      object_parse.should contain("subject")
      object_parse["subject"].should eq("Good News")

      object_parse.should contain("content")
      object_parse["content"][0].should contain("type")
      object_parse["content"][0].should contain("value")
      object_parse["content"][0]["value"].should eq("No, I am your father.")
    end
  end
end
