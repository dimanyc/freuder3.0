class User < ApplicationRecord

  validates_presence_of [:screen_name,
                         :uid,
                         :token,
                         :secret]

  def self.from_omniauth(response)
    @uid         = response.uid
    @screen_name = response.info.nickname
    @token       = response.credentials.token
    @secret      = response.credentials.secret
    where(uid: @uid,
          screen_name: @screen_name
         ).first || create_from_omniauth
  end

  def self.create_from_omniauth
    create! do |user|
      user.uid         = @uid
      user.token       = @token
      user.secret      = @secret
      user.screen_name = @screen_name
    end
  end

end
