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
  include Cms::Helpers::ImageHelper

  before_action :initialize_breadcrumbs
  before_action :initialize_service_categories

  def render_not_found
    @head_title = "Сторінку не знайдено"
    render template: "errors/not_found.html.slim", layout: "empty_layout.html.slim", status: 404
  end

  def initialize_breadcrumbs
    @_breadcrumbs = []
  end

  def add_breadcrumb(name, url = nil)
    b = { }
    name = name.to_s
    b[:key] = name
    b[:name] = (I18n.t("breadcrumbs.#{name}", raise: true) rescue name.humanize)
    path_method = "#{name}_path"
    b[:url] = url.nil? && respond_to?(path_method) ? send(path_method) : url
    @_breadcrumbs << b
  end

  def add_home_breadcrumb
    add_breadcrumb("home", root_path)
  end



  def render_breadcrumbs
    raw(render_to_string partial: "breadcrumbs")
  end

  def render_page_banner
    raw(render_to_string(partial: "page_banner"))
  end

  def pjax?
    !!request.headers['X-PJAX']
  end

  helper_method :render_breadcrumbs
  helper_method :render_page_banner

  def initialize_service_categories
    @service_categories ||= ServiceCategory.published.sort_by_sorting_position
  end
end
