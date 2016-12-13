# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class TwitterFeedChannel < ApplicationCable::Channel

  def subscribed
    stream_from "twitter_feed"
  end

end
