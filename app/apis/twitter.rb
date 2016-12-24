class TwitterAPI

  def initialize(token, secret)
    @token  = token
    @secret = secret
  end

  def start_streaming
    stream.user do |object|
      case object
      when Twitter::Tweet
        ActionCable.server.broadcast(
          'twitter_feed',
          text: object.text)
      end
    end
  end

  def get_home_timeline
    client.home_timeline
  end

  private

  def client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['API_KEY']
      config.consumer_secret     = ENV['API_SECRET']
      config.access_token        = @token
      config.access_token_secret = @secret
    end
  end

  def stream
    Twitter::Streaming::Client.new do |config|
      config.consumer_key        = ENV['API_KEY']
      config.consumer_secret     = ENV['API_SECRET']
      config.access_token        = @token
      config.access_token_secret = @secret
    end
  end

end
