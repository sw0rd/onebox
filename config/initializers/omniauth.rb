GOOGLE_API = 'x'
YAHOO_API = 'x'


Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, '4x', 'lxBugCbs'
  provider :facebook, '18x37', '1e9xfa6e3f07'
end

