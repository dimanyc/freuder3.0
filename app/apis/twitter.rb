class TwitterAPI

  # :nocov:
  def client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['API_KEY']
      config.consumer_secret     = ENV['API_SECRET']
      config.access_token        = ENV['TOKEN']
      config.access_token_secret = ENV['SECRET']
    end
  end

  # token and secret are passed as args
  # because the streaming is inited in a fork
  def stream(token, secret)
    Twitter::Streaming::Client.new do |config|
      config.consumer_key        = ENV['API_KEY']
      config.consumer_secret     = ENV['API_SECRET']
      config.access_token        = token
      config.access_token_secret = secret
    end
  end
  # :nocov:

end
