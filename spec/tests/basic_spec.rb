# rspec spec/tests/basic_spec.rb
describe "Leadersend" do
  describe "config" do
    it "default username should be ok" do
      expect(Leadersend.config.username).to eq "example@domain.com"
    end
    it "default api_key should be ok" do
      expect(Leadersend.config.api_key).to eq "0953e545acdf063cb8a903a174gh721f"
    end
    it "default api_url should be ok" do
      expect(Leadersend.config.api_url).to eq "http://api.leadersend.com/1.0/?output=json"
    end
    it "default host should be ok" do
      expect(Leadersend.config.host).to eq "smtp.leadersend.com"
    end
  end
end