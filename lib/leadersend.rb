require 'leadersend/version'
require 'leadersend/mailer'

module Leadersend
  ROOT = File.expand_path("../..", __FILE__)

  def self.root
    return ROOT
  end

  class << self
    attr_accessor :config
  end

  def self.configure
    self.config ||= Config.new
    yield(config)
  end

  class Config
    attr_accessor :api_url, :host, :username, :api_key

    def initialize
      @api_url  = "http://api.leadersend.com/1.0/?output=json"
      @host     = "smtp.leadersend.com"
      @username = "example@domain.com"
      @api_key  = "0953e545acdf063cb8a903a174gh721f"
    end

  end

  Leadersend.configure {}
end

LS = Leadersend
