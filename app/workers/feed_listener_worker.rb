class FeedListenerWorker

  include Sidekiq::Worker

  def perform(user_id)
    puts "=====#{user_id}"
    puts "=====#{ENV['TOKEN']}"
    puts "=====#{ENV['SECRET']}"
    stream = TwitterAPI.new.stream
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
