class TwitterAPI

  attr_accessor :client, :stream

  def initialize(token, secret)
    @token  = token
    @secret = secret
  end

  # :nocov:
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
  # :nocov:

end
