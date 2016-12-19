# sendgrid.cr

Simple lib to send mail using Sendgrid in Crystal-Lang

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  sendgrid:
    github: dlanileonardo/sendgrid
```

## Usage

```crystal
require "sendgrid"
```

### Using Helpers

```
client = Sendgrid::Client.new("https://api.sendgrid.com/v3/mail/send", API_KEY)
message = Sendgrid::Message.new
message.from = Sendgrid::Address.new(email="darthvader@host.com", name="Darth Vader")
message.to << Sendgrid::Address.new(email="lukeskywalker@starwars.stars", name="Luke Skywalker")
message.subject = "Good News"
message.content = Sendgrid::Content.new("No, I am your father.")
send = client.send message
puts send.status_code
puts send.body
```

### Print JSON

```
message = Sendgrid::Message.new
message.from = Sendgrid::Address.new(email="darthvader@host.com", name="Darth Vader")
message.to << Sendgrid::Address.new(email="lukeskywalker@starwars.stars", name="Luke Skywalker")
message.subject = "Good News"
message.content = Sendgrid::Content.new("No, I am your father.")
puts message.to_json
```

## Contributing

1. Fork it ( https://github.com/dlanileonardo/sendgrid/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [dlanileonardo](https://github.com/dlanileonardo)  - creator, maintainer
