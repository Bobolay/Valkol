class ServicesController < ApplicationController
  def index
    @service_categories = ServiceCategory.published.sort_by_sorting_position

  end

  def show
    @service = Service.first
    @service_categories = ServiceCategory.published.sort_by_sorting_position
  end
end