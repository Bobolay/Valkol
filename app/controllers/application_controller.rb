class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception

  include ActionView::Helpers::OutputSafetyHelper
  include ActionView::Helpers::AssetUrlHelper
  include ActionView::Helpers::TagHelper
  include Cms::Helpers::PagesHelper
  extend Cms::Helpers::PagesHelper::ClassMethods
  include Cms::Helpers::MetaDataHelper
  include Cms::Helpers::NavigationHelper

  before_action :initialize_breadcrumbs

  def render_not_found
    render template: "errors/not_found.html.slim", layout: "empty_layout", status: 404
  end

  def initialize_breadcrumbs
    @_breadcrumbs = []
  end

  def add_breadcrumb(name, url = nil)
    b = { }
    name = name.to_s
    b[:name] = (I18n.t("breadcrumbs.#{name}", raise: true) rescue name.humanize)
    b[:url] = url.nil? ? send("#{name}_path") : url
    @_breadcrumbs << b
  end

  def add_home_breadcrumb
    add_breadcrumb("Home", root_path)
  end



  def render_breadcrumbs
    raw(render_to_string partial: "breadcrumbs")
  end

  def render_page_banner
    raw(render_to_string(partial: "page_banner"))
  end

  helper_method :render_breadcrumbs
  helper_method :render_page_banner
end
