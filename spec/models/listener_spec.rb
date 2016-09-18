require 'rails_helper'

RSpec.describe Listener, type: :model do

  let(:tweet) { build(:tweet) }

  it { should validate_presence_of(:name) }

  it { should have_many(:tweets).through(:listener_tweets) }

  it 'should handle empty keyword scenario' do
    expect{ create(:listener, :no_keywords ) }
      .to raise_error(
    ActiveRecord::RecordInvalid,
    'Validation failed: Search terms \'keywords\' cannot be empty')
  end

  context 'searching for case-sensitive keywords' do

    before(:all) do
      @listener  = create(:listener, keywords: ['Foo'])
      @tweet = create(:tweet, body: 'Foo #bar #baz @fizz,bizz')
    end

    it 'should store matched tweets' do
      @listener.analyze(@tweet)
      expect(@listener.tweets).to include(@tweet)
    end

    it 'should return matching keywords that were found in the @tweet' do
      @listener.analyze(@tweet)
      expect(
        ListenerTweet.find_by(
          listener_id: @listener.id,
          tweet_id:    @tweet.id
        ).keyword_slips)
          .to include('foo')
    end

    it 'should create new join table instance when matching keywords are found' do
      listener = create(:listener, :not_case_sensitive, keywords: ['foo'])
      expect{ listener.analyze(@tweet) }.to change{ ListenerTweet.count }.by(1)
    end

  end

end
