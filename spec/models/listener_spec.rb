require 'rails_helper'

RSpec.describe Listener, type: :model do

  it { should validate_presence_of(:name) }

  it { should have_many(:slips).dependent(:destroy) }

  it 'should destory associated .slips on self#destroy' do
    listener = create(:listener, :with_slips)
    expect{ listener.destroy }
      .to change { Slip.count }.by (-1)
  end

  it 'should not be stored with empty search terms' do
    expect{ create(:listener, :empty_search_terms ) }
      .to raise_error(
    ActiveRecord::RecordInvalid,
    'Validation failed: Search terms \'keywords\'' \
    ' cannot be empty')
  end

  context 'parsing' do

    before(:each) do

      @listener = create(
        :listener,
        keywords:         ['foo'],
        key_mentions:     ['@dimanyc'],
        key_hashtags:     ['#reactjs'],
        hashtags:         true,
        mentions:         true,
        include_replies:  false
      )

      @tweet = OpenStruct.new(
        id:           rand(1...2),
        full_text:    'foo Bar fizz @abc',
        mentions:     ['@dimanyc'],
        hashtags:     ['#reactjs'],
        author:       '@' + Faker::Internet.user_name,
      )
    end

    context 'happy path' do

      it 'should ignore tweets that are replies' \
         ' when .include_replies setting is off' do
        reply_tweet = @tweet
        reply_tweet[:in_reply_to_screen_name] = '@dimanyc'
        @listener.parse(reply_tweet)
        expect(@listener.slips).to be_empty
      end

      it 'should identify tweets with matching terms' do
        @listener.parse(@tweet)
        expect(@listener.slips.first.body)
          .to match(@tweet.body)
      end

      it 'should not create new instance of Slip' do
        expect{ @listener.parse(@tweet) }
          .to change { Slip.count }.by(1)
      end

      it 'should identify matching keywords' do
        @listener.parse(@tweet)
        expect(@listener.slips.first.keywords)
          .to include @listener.keywords.first
      end

      it 'should identify matching hashtags' do
        @listener.parse(@tweet)
        expect(@listener.slips.first.hashtags)
          .to include @listener.key_hashtags.first
      end

      it 'should identify matching mentions' do
        @listener.parse(@tweet)
        expect(@listener.slips.first.mentions)
          .to include @listener.key_mentions.first
      end

      it 'should identify matching' \
         'non-case-sensitive keywords' do
        listener = create(:listener,
                          keywords: ['bar'],
                          case_sensitive: false)
        listener.parse(@tweet)
        expect(listener.slips.first.keywords)
          .to include listener.keywords.first
      end

      it 'should identify hashtags mentions and keywords' \
          ' with keywords_everywhere setting on' do
        listener = create(:listener,
                          use_keywords_everywhere: true,
                          keywords: ['abc'])
        listener.parse(@tweet)
        expect(listener.slips.first.keywords)
          .to include listener.keywords.first
      end

    end

    context 'sad path' do

      before(:each) do
        @bad_tweet = OpenStruct.new(
          id:           rand(1...2),
          full_text:    'I hit the bottom and escape',
          mentions:     ['@thom'],
          hashtags:     ['#yorke'],
          author:       '@' + Faker::Internet.user_name
        )
      end

      it 'should ignore tweets with no matching terms' do
        tweet_with_no_matching_terms = @bad_tweet
        @listener.parse(tweet_with_no_matching_terms)
        expect(@listener.slips).to be_empty
      end

      it 'shuold ignore capitalized matching keywords' \
         'when case-sensitive setting is on' do
        @tweet_with_lowercased_keyword = @bad_tweet
        listener = create(:listener,
                          keywords: ['Bottom'],
                          case_sensitive: true)
        listener.parse(@tweet_with_lowercased_keyword)
      end

      it 'should ignore tweets with mentions matching
          they listener.keyword when :use_keywords_everywhere
          setting is off' do
        listener = create(:listener,
                          keywords: ['@thom'],
                          use_keywords_everywhere: false)
        listener.parse(@bad_tweet)
      end

      it 'should ignore tweets with mentions matching they' \
         'listener.keyword when ' \
         ':use_keywords_everywhere setting is off' do
        listener = create(:listener,
                          keywords: ['#yorke'],
                          use_keywords_everywhere: false)
        listener.parse(@tweet)
      end

    end

  end

end
