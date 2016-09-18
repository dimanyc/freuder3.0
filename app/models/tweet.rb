class Tweet < ApplicationRecord

  validates_presence_of :author, :body

  has_many :listener_tweets
  has_many :listeners, through: :listener_tweets

end
