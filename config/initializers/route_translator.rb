RouteTranslator.config do |config|
  config.force_locale = false
  #puts "I18n.available_locales: #{I18n.available_locales}"
  #config.available_locales = I18n.available_locales
  config.available_locales = [:uk, :en]
end