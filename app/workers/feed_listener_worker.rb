class FeedListenerWorker

  include Sidekiq::Worker

  def perform(user_id, token, secret)
    stream = TwitterAPI.new.stream(token, secret)
    stream.user do |object|
      case object
      when Twitter::Tweet
        ActionCable.server.broadcast(
          'twitter_feed',
          text: object.text)
      end
    end
  end

end
