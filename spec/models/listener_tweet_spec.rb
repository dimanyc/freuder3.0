require 'rails_helper'

RSpec.describe ListenerTweet, type: :model do

  it { should validate_presence_of(:tweet_id) }
  it { should validate_presence_of(:listener_id) }

  it { should belong_to(:tweet) }
  it { should belong_to(:listener) }

end
