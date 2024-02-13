require "rails_helper"

RSpec.describe Shortener do
      it "shortens a given URL to a 7 characters lookup code" do
            url = "https://rubygems.org/gems/rspec-rails/versions/6.1.1"
            shortener = Shortener.new(url)
            expect(shortener.lookup_code.length).to eq(7)
      end
      
      it "gives each URL its own loockup code" do
            url = "https://rubygems.org/gems/rspec-rails/versions/6.1.1"
            shortener = Shortener.new(url)
            code_1 = shortener.lookup_code

            url = "https://rubygems.org/gems/rspec-rails/versions/6.0.3"
            shortener = Shortener.new(url)
            code_2 = shortener.lookup_code

            expect(code_2).not_to eq(code_1)
      end

      it "generates a Link record with a unique lookup code" do
            url = "https://rubygems.org/gems/rspec-rails/versions/6.1.1"
            shortener = Shortener.new(url)
            link = shortener.generate_short_link
            expect(link.valid?).to be(true)

            link_2 = shortener.generate_short_link
            expect(link_2.valid?).to be(true)
      end 

end
