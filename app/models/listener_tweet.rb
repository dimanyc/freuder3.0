require_relative '../serializers/hash_serializer'

class ListenerTweet < ApplicationRecord

  validates_presence_of :listener_id, :tweet_id

  belongs_to :tweet
  belongs_to :listener

  store_accessor :slips,
    :hashtag_slips,
    :mention_slips,
    :keyword_slips

end
