class Slip < ApplicationRecord

  validates_presence_of :tweet_id
  belongs_to :listener

  store_accessor :slips,
    :keywords,
    :mentions,
    :hashtags

end
