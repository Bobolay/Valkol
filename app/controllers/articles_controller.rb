class ArticlesController < ApplicationController
  def index
    @articles = resource_class.published

    set_page_metadata(resource_plural_name)
    set_page_banner_image(@page_instance.try(:page_banner))

    add_home_breadcrumb
    add_breadcrumb(resource_plural_name)



    if pjax?
      render template: "application/_articles_collection", layout: false
    end
  end

  def index_with_filter

  end

  def show
    @article = Article.published.where(url_fragment: params[:id]).first
    if @article.nil?
      return render_not_found
    end
    add_home_breadcrumb
    add_breadcrumb(resource_plural_name)
    add_breadcrumb(@article.name)

    set_page_metadata(@article)
    set_page_banner_image(@page_instance.try(:page_banner))
  end

  def resource_class

  end

  def resource_plural_name

  end

  helper_method :resource_plural_name
end