require 'omniauth'

require 'hash_dot'
OmniAuth.config.test_mode = true

# omniauth_hash = {
#   provider:    'twitter',
#   uid:         '12345',
#   info:        { nickname: 'dimanyc' },
#   credentials: {
#   token:    '123123',
#   secret:   '321312'
# }
# }.to_dot
# oauth_hash = {
#   "provider"=>"twitter",
#   "uid"=>"59153881",
#   "info"=>{
#   "nickname"=>"DimaNYC",
#   "credentials"=>{
#   "token"=>"123",
#   "secret"=>"321"
# }
# }
# }.to_dot
#
omniauth_hash = { 'provider' => 'github',
                  'uid' => '12345',
                  'info' => {
  'name' => 'natasha',
  'email' => 'hi@natashatherobot.com',
  'nickname' => 'NatashaTheRobot'
},
'extra' => {'raw_info' =>
            { 'location' => 'San Francisco',
              'gravatar_id' => '123456789'
            }
}
}.to_dot
OmniAuth.config.add_mock(:twitter, omniauth_hash)
