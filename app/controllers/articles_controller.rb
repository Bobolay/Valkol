class ArticlesController < ApplicationController
  def index
    @publications = Publication.published
  end

  def index_with_filter

  end

  def show

  end
end