class Listener < ApplicationRecord

  validates_presence_of :name
  validate :search_terms, :valid_search_terms?

  has_many :slips, dependent: :destroy

  store_accessor :search_terms,
    :keywords,
    :key_mentions,
    :key_hashtags

  store_accessor :options,
    :case_sensitive,
    :hashtags,
    :mentions,
    :use_keywords_everywhere,
    :include_replies

  keys = [
    'hashtags',
    'mentions',
    'case_sensitive',
    'use_keywords_everywhere']
  keys.each do |key|
    define_method("#{key}?") do
      send(key) == true
    end
  end

  def parse(tweet)
    return if
      tweet.in_reply_to_screen_name.present? &&
      include_replies == false
    @tweet = tweet
    @slip = Slip.new(listener_id: id,
                     tweet_id: @tweet.id)
    parse_hashtags if hashtags?
    parse_mentions if mentions?
    parse_keywords unless keywords.empty?
    @slip.save! if @slip.attribute_changed?(:slips)
  end

  private

  def parse_hashtags
    matching_hashtags = @tweet.hashtags & key_hashtags
    return if matching_hashtags.empty?
    @slip.hashtags.push(matching_hashtags).flatten!
  end

  def parse_mentions
    matching_mentions = @tweet.mentions & key_mentions
    return if matching_mentions.empty?
    @slip.mentions.push(matching_mentions).flatten!
  end

  def parse_keywords
    tweet_keywords   = handle_keyword_search_option(@tweet)
    matched_keywords =
      handle_case_sensitive_keyword_search(tweet_keywords)
    return if matched_keywords.empty?
    @slip.keywords = matched_keywords
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
      tweet.full_text.gsub(/[@#]/,'').split(' ').map(&:strip)
    else
      tweet.full_text.scan(/\w+/)
    end
  end

  def valid_search_terms?
    if keywords.empty? &&
        key_mentions.empty? &&
        key_hashtags.empty?
      errors.add(:search_terms, '\'keywords\' cannot be empty')
    end
  end

end
