class FeedListenerWorker

  include Sidekiq::Worker

  def perform(user_id, token, secret)
    TwitterAPI.new(token, secret).start_streaming
  end

end
