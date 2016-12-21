require 'omniauth'
OmniAuth.config.test_mode = true

omniauth_hash = { provider:    'twitter',
                  uid:         '12345',
                  info:        { nickname: 'habibulin' },
                  credentials: { token:    '123',
                                 secret:   '234234'}
}
OmniAuth.config.add_mock(:twitter, omniauth_hash)
