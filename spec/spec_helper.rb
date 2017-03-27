require 'propublica_congress'
require 'vcr'
require 'webmock/rspec'
 
# Set your ProPublica API key as an environment variable to run the tests
API_KEY = ENV['PROPUBLICA_API_KEY']
PropublicaCongress::Base.api_key = API_KEY
 
RSpec.configure do |config|
  # some (optional) config here
end
 
VCR.configure do |c|
  c.cassette_library_dir = "spec/fixtures/cassettes"
  c.hook_into :webmock
  c.default_cassette_options = { :record => :once }
end