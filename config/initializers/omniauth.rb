OmniAuth.config.allowed_request_methods = [:post, :get]
OmniAuth.config.silence_get_warning = true
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :github, "42b4d1eceac90c28c82c", "605da7835b79f54c7c34195fcc51b22dfc71be8c", scope: 'user:email'
end