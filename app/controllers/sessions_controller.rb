class SessionsController < ApplicationController

  def create
    api_response = request.env['omniauth.auth']
    # puts  api_response.provider
    @@token  = api_response.credentials.token
    @@secret = api_response.credentials.secret
    User.from_omniauth(api_response)

    redirect_to root_path, notice: 'pidarasiki'
  end

end
