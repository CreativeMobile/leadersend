# Leadersend

Ruby wrapper for Leadersend transactional email sending service

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'leadersend'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install leadersend

## Usage

LS can be used instead of Leadersend

### Configure
```ruby
# /config/initializers/leadersend.rb

Leadersend.configure do |config|
  config.username = "example@domain.com"
  config.api_key  = "0953e545acdf063cb8a903a174gh721f" # place your key here
  config.api_url  = "http://api.leadersend.com/1.0/?output=json" # leave as is
  config.host     = "smtp.leadersend.com" # leave as is
end
```

Setup ActionMailer::Base.smtp_settings with
```ruby
ActionMailer::Base.smtp_settings = {
  :address        => Leadersend.config.host,
  :port           => '587',
  :authentication => :plain,
  :user_name      => Leadersend.config.username,
  :password       => Leadersend.config.api_key,
  :domain         => 'example-domain.com'
}
```

### Send Email
Instantiate a Leadersend::Mail object with given parameters
```ruby
mailer = Leadersend::Mail.new to: self.email, from: from, fromname: fromname, subject: subject, template_path: template_path, locals: locals, title: title
```
Parameter examples and explanations:
```ruby
to: "example@email.com"
from: "coworker@company.com"
fromname: "Bob"
subject: "Friday party!"
template_path = "delivery/partials/party_markup"
title = "It is friday!"
locals = {variable: value, another_variable: different_value} # These will be made available in the template
```

Call the #send method on the instantiated objecto send an email. This method returns a hash
```ruby
sent_mail_hash = mailer.send
```

### Log the sending
Result hash content and explanations:
```ruby
{
  title: @title,
  body: @template, # returns the actual markup generated
  status: status, # very useful, returns "sent" on success and "error" on fail
  subject: @subject,
  to_address: @to,
  response: result.inspect # a verbose repeat of what you already knew, for example
  :response=>"[{\"email\"=>\"example@email.com\", \"status\"=>\"sent\", \"id\"=>\"ecf0ea8f33df690a02c83ccc86x678be\"}]"
}
```

Use this information to populate a logging object like SentMail




