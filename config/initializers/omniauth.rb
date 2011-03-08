GOOGLE_API = 'ABQIAAAA50aVEQhwqSIbzfgbTlQ4SxSXc6Nw8u9opE6A42eZAo88N8mmfRQd4mSOX751tBvEXJfvUq84yLC1KQ'
YAHOO_API = 'PmEKFgSxg64vTpu_bXC9k8xwnbQQLrkAoLb3IUTSSK3yYyHGX6EubDN3ITk65HR5Negmbh.c'


Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, '4tuML4R739WakcXq4YEdfw', 'lywwouBAyLzgCJEuz1MkLzMaILsJCjhuWpL8BugCbs'
  provider :facebook, '189836181047137', '1e9a8c249eef296d27c7c443fa6e3f07'
end

