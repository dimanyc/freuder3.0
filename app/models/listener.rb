require_relative '../serializers/hash_serializer'

class Listener < ApplicationRecord

  validates_presence_of :name
  validate :search_terms, :valid_search_terms?

  has_many :listener_tweets
  has_many :tweets, through: :listener_tweets

  serialize [:search_terms, :options], HashSerializer

  store_accessor :search_terms,
    :keywords,
    :key_mentions,
    :key_hashtags

  store_accessor :options,
    :case_sensitive?,
    :hashtags?,
    :mentions?,
    :use_keywords_everywhere? # use [keywords] for searching  #hashtags and @mentions?

  def analyze(tweet)
    listener_tweet = ListenerTweet.new(tweet_id: tweet.id, listener_id: id)
    look_for_matching_hashtags(tweet, listener_tweet) if hashtags?
    look_for_matching_mentions(tweet, listener_tweet) if mentions?
    look_for_matching_keywords(tweet, listener_tweet)
    listener_tweet.save! if listener_tweet.changed?
  end

  private

  def look_for_matching_hashtags(tweet, listener_tweet)
    hashtags = tweet.scan(/\#(\w+)/).flatten
    return if hashtags.nil? || (hashtags & key_hashtags).count == 0
    listener_tweet.hashtag_slips.push(hashtags & key_hashtags)
  end

  def look_for_matching_mentions(tweet, listener_tweet)
    mentions = tweet.scan(/\@(\w+)/).flatten
    return if mentions.nil? || (mentions & key_mentions).count == 0
    listener_tweet.mention_slips.push(mentions & key_mentions)
  end

  def look_for_matching_keywords(tweet, listener_tweet)
    tweet_keywords   = handle_keyword_search_option(tweet)
    matched_keywords = handle_case_sensitive_keyword_search(tweet_keywords)
    return if tweet_keywords.nil? || matched_keywords.empty?
    listener_tweet.keyword_slips = matched_keywords
  end

  def handle_case_sensitive_keyword_search(tweet_keywords)
    if case_sensitive?
      tweet_keywords & keywords
    else
      tweet_keywords.map(&:downcase) & keywords.map(&:downcase)
    end
  end

  def handle_keyword_search_option(tweet)
    if use_keywords_everywhere?
      tweet.body.scan(/\w/).flatten
    else
      tweet.body.gsub(/([@#])([a-z\d_]+)/, '')
        .gsub(/\W/, ' ')
        .gsub(/\s+/, ' ')
        .split(' ')
    end
  end

  def valid_search_terms?
    if search_terms['keywords'].empty?
      errors.add(:search_terms, '\'keywords\' cannot be empty')
    end
  end

end
