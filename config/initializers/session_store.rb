# Be sure to restart your server when you modify this file.

if Rails.env.production?
    Rails.application.config.session_store :cookie_store, key: '_saasapp_session', domain: ".nomadagile.com"
else
    Rails.application.config.session_store :cookie_store, key: '_saasapp_session', domain: '.lvh.me'
end
