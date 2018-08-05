class HomeBanner < ActiveRecord::Base
  attr_accessible *attribute_names

  globalize :name, :description

  image :image, styles: { small: "192x108#", large: "1920x1080#" }

  boolean_scope :published
  scope :sort_by_sorting_position, -> { order(sorting_position: :asc) }
  default_scope do
    sort_by_sorting_position
  end

  has_cache do
    pages :home
  end

  has_link :linkable

  def url
    linkable.try(:url).presence
  end
end
