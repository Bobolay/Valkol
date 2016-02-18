class ServicesController < ApplicationController
  def index
    @service_categories = ServiceCategory.published.sort_by_sorting_position

    set_page_metadata('services')
    set_page_banner_image(@page_instance.try(:page_banner))
  end

  def show
    @service = Service.published.where(url_fragment: params[:id]).first
    @service_categories = ServiceCategory.published.sort_by_sorting_position
    set_page_metadata(@service)
    set_page_banner_image(@page_instance.try(:page_banner))
  end
end