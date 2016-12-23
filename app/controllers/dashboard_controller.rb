class DashboardController < ApplicationController

  before_action :establish_api_connection, only: :show
  before_action :auth_user

  def show
    @dashboard_props = {
      name:   current_user.screen_name,
      tweets: @rest.home_timeline }
    start_stream
  end

  private

  def establish_api_connection
    @rest = TwitterAPI.new.client
  end

  def start_stream
    user_id = current_user.id
    FeedListenerWorker.perform_async(user_id,
                                     ENV['TOKEN'],
                                     ENV['SECRET'])
  end

end
