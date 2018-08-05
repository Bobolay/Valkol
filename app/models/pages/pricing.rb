class Pages::Pricing < Cms::Page
  include Cms::LocalizedRoutes::UrlHelper::ActiveRecordExtension

  def url(locale = I18n.locale)
    url_helpers.send("#{route_name}_#{locale}_path")
  end
end