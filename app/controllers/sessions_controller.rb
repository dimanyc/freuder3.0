class SessionsController < ApplicationController

  def create
    if @api_response = request.env['omniauth.auth']
      user = User.from_omniauth(@api_response)
      session[:user_id] = user.id
      cookies[:user_id] = user.id
      assign_access_vars
      redirect_to dashboard_path
    else
      redirect_to root_path, notice: 'Something went south'
    end
  end

  private

  def assign_access_vars
    ENV['TOKEN']  = @api_response.credentials.token
    ENV['SECRET'] = @api_response.credentials.secret
  end

end
