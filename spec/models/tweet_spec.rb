require 'rails_helper'

RSpec.describe Tweet, type: :model do

  it { should validate_presence_of(:author) }
  it { should validate_presence_of(:body) }

  it { should have_many(:listeners).through(:listener_tweets) }

end
