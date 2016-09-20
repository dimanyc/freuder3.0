require 'rails_helper'

RSpec.describe Slip, type: :model do

  it { should validate_presence_of(:tweet_id) }
  it { should belong_to(:listener) }

  it 'should respond to slips.keys(JSON) attributes' do
    expect(subject).to respond_to(:keywords)
    expect(subject).to respond_to(:mentions)
    expect(subject).to respond_to(:hashtags)
  end

end

