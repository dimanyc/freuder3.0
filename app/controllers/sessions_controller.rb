class SessionsController < ApplicationController

  def create
    api_response = request.env['omniauth.auth']
    @@token  = api_response.credentials.token
    @@secret = api_response.credentials.secret
    User.from_omniauth(api_response)
    redirect_to root_path, notice: 'Signed in!'
  end

end
