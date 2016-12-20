class FeedListenerWorker
  include Sidekiq::Worker

  def perform(user_id)
    user   = User.find(user_id)
    stream = TwitterAPI.new(user.token,
                            user.secret).stream
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
