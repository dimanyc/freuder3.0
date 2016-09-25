class DashboardController < ApplicationController
  before_action :show, :establish_api_connection

  def show
  end

  private

  def establish_api_connection
    @twitter = TwitterAPI.new
  end

end
