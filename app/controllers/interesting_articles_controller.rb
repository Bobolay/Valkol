class InterestingArticlesController < ArticlesController
  def resource_class
    InterestingArticle
  end

  def resource_plural_name
    "interesting_articles"
  end
end