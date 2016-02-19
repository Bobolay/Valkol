class ServicesController < ApplicationController
  def index


    set_page_metadata('services')
    set_page_banner_image(@page_instance.try(:page_banner))

    add_home_breadcrumb
    add_breadcrumb('services')
  end

  def show
    @service = Service.published.where(url_fragment: params[:id]).first

    if @service.nil?
      return render_not_found
    end

    set_page_metadata(@service)
    set_page_banner_image(@page_instance.try(:page_banner))

    add_home_breadcrumb
    add_breadcrumb('services')
    add_breadcrumb(@service.name)
  end
end