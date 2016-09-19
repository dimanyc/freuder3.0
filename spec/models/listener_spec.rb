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
  context 'parsing' do

    context 'happy path:' do

      before(:each) do
        @listener = create(
          :listener,
          keywords:     ['foo'],
          key_mentions: ['@dimanyc'],
          key_hashtags: ['#reactjs'],
          hashtags:     true,
          mentions:     true
        )
        @tweet = create(
          :tweet,
          body:         'foo Bar fizz @abc',
          mentions:     ['@dimanyc'],
          hashtags:     ['#reactjs']
        )
      end

      it 'should identify tweets with matching terms' do
        @listener.parse(@tweet)
        expect(@listener.tweets).to include(@tweet)
      end

      it 'should not create new ListenerTweet join table instance' do
        expect{ @listener.parse(@tweet) }.to change { ListenerTweet.count }.by(1)
      end

      it 'should identify matching keywords' do
        @listener.parse(@tweet)
        expect( ListenerTweet.find_by(
          tweet_id:     @tweet.id,
          listener_id:  @listener.id
        ).keyword_slips)
          .to include @listener.keywords.first
      end

      it 'should identify matching hashtags' do
        @listener.parse(@tweet)
        expect( ListenerTweet.find_by(
          tweet_id:     @tweet.id,
          listener_id:  @listener.id
        ).hashtag_slips)
          .to include @listener.key_hashtags.first
      end

      it 'should identify matching mentions' do
        @listener.parse(@tweet)
        expect( ListenerTweet.find_by(
          tweet_id:     @tweet.id,
          listener_id:  @listener.id
        ).mention_slips)
          .to include @listener.key_mentions.first
      end

      it 'should identify matching non-case-sensitive keywords' do
        listener = create(:listener, keywords: ['bar'])
        listener.parse(@tweet)
        expect( ListenerTweet.find_by(
          tweet:        @tweet.id,
          listener_id:  listener.id
        ).keyword_slips)
          .to include (listener.keywords.first)

      end

      it 'should identify hashtags mentions and keywords with keywords_everywhere setting on' do
        listener = create(:listener, use_keywords_everywhere: true, keywords: ['abc'])
        listener.parse(@tweet)
        expect( ListenerTweet.find_by(
          tweet:        @tweet.id,
          listener_id:  listener.id
        ).keyword_slips)
          .to include (listener.keywords.first)

      end

    end

    context 'sad path:' do

      before(:each) do
        @listener = create(
          :listener,
          keywords:     ['random'],
          key_mentions: ['@foo'],
          key_hashtags: ['#bar']
        )
        @tweet    = create(
          :tweet,
          body:     ['foo Bar fizz'],
          mentions: ['@dimanyc'],
          hashtags: ['#reactjs']
        )
      end

      it 'should ignore tweets with no matching terms' do
        @listener.parse(@tweet)
        expect(@listener.tweets).to_not include(@tweet)
      end

      it 'should not create new ListenerTweet join table instance' do
        @listener.parse(@tweet)
        expect{ @listener.tweets }.to change { ListenerTweet.count }.by(0)
      end

    end

  end

end
