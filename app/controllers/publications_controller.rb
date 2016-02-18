class PublicationsController < ArticlesController
  def resource_class
    Publication
  end

  def resource_plural_name
    "publications"
  end
end