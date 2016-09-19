class Listener < ApplicationRecord

  validates_presence_of :name
  validate :search_terms, :valid_search_terms?

  has_many :listener_tweets
  has_many :tweets, through: :listener_tweets

  # serialize [:search_terms, :options], JSON
  # serialize :options, HashSerializer

  store_accessor :search_terms,
    :keywords,
    :key_mentions,
    :key_hashtags

  store_accessor :options,
    :case_sensitive,
    :hashtags,
    :mentions,
    :use_keywords_everywhere # use [keywords] for searching  #hashtags and @mentions?

  keys = ['hashtags','case_sensitive','mentions','use_keywords_everywhere']
  keys.each do |key|
    define_method("#{key}?") do
      send(key) == true
    end
  end

  def parse(tweet)
    @tweet = tweet
    @listener_tweet = ListenerTweet.new(tweet_id: tweet.id, listener_id: id)
    parse_hashtags if hashtags?
    parse_mentions if mentions?
    parse_keywords unless keywords.empty?
    @listener_tweet.save! if @listener_tweet.attribute_changed?(:slips)
  end

  private

  def parse_hashtags
    matching_hashtags = @tweet.hashtags & key_hashtags
    return if matching_hashtags.empty?
    @listener_tweet.hashtag_slips.push(matching_hashtags).flatten!
  end

  def parse_mentions
    matching_mentions = @tweet.mentions & key_mentions
    return if matching_mentions.empty?
    @listener_tweet.mention_slips.push(matching_mentions).flatten!
  end

  def parse_keywords
    tweet_keywords   = handle_keyword_search_option(@tweet)
    matched_keywords = handle_case_sensitive_keyword_search(tweet_keywords)
    return if matched_keywords.empty?
    @listener_tweet.keyword_slips = matched_keywords
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
      tweet.body.gsub(/[@#]/,'').split(' ').map(&:strip)
    else
      tweet.body.scan(/\w+/)
    end
  end

  def valid_search_terms?
    if search_terms['keywords'].empty?
      errors.add(:search_terms, '\'keywords\' cannot be empty')
    end
  end

end
