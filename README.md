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

### Configure



