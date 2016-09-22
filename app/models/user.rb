class User < ApplicationRecord

  validates_presence_of :screen_name, :uid

  def self.from_omniauth(response)
    @uid         = response.uid
    @screen_name = response.info.nickname
    where(uid: @uid,
          screen_name: @screen_name
         ).first || create_from_omniauth
  end

  def self.create_from_omniauth
    create! do |user|
      user.uid         = @uid
      user.screen_name = @screen_name
    end
  end

end
