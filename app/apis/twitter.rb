class TwitterAPI

  # :nocov:
  def client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['API_KEY']
      config.consumer_secret     = ENV['API_SECRET']
      config.access_token        = ENV['TOKEN']#@token
      config.access_token_secret = ENV['SECRET']#@secret
    end
  end

  def stream
    Twitter::Streaming::Client.new do |config|
      config.consumer_key        = ENV['API_KEY']
      config.consumer_secret     = ENV['API_SECRET']
      config.access_token        = ENV['TORKEN']#@token
      config.access_token_secret = ENV['SECRET']#@secret
    end
  end
  # :nocov:

end
