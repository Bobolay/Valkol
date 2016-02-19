class ServicesController < ApplicationController
  def index


    set_page_metadata('services')
    set_page_banner_image(@page_instance.try(:page_banner))
  end

  def show
    @service = Service.published.where(url_fragment: params[:id]).first

    if @service.nil?
      return render_not_found
    end



    set_page_metadata(@service)
    set_page_banner_image(@page_instance.try(:page_banner))
  end
end