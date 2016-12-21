require 'simplecov'
SimpleCov.start

require 'factory_girl_rails'
require 'support/database_cleaner'
require 'support/oauth_magic'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.include FactoryGirl::Syntax::Methods

end

def stub_twitter_api
  client = double(Twitter::REST::Client, home_timeline: :true)
  stream = double(Twitter::Streaming::Client, user: true)
  api = double(TwitterAPI, client: client, stream: stream)
  allow(TwitterAPI)
    .to receive(:new)
    .and_return(api)
end
