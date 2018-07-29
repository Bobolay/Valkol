class Service < ActiveRecord::Base
  attr_accessible *attribute_names

  globalize :name, :url_fragment, :short_description, :content

  belongs_to :service_category
  attr_accessible :service_category

  image :avatar
  image :banner

  has_seo_tags
  has_sitemap_record
  has_cache do
    pages :about_us, :contacts, :home, :interesting_articles, :pricing, :publications, :services
  end

  scope :sort_by_sorting_position, -> { order("sorting_position asc") }
  boolean_scope :published

  default_scope do
    sort_by_sorting_position
  end

  def linkable_path
    category_str = service_category.try(:name).presence || "[no_service_category]"
    name_str = name.presence || "[Service ##{id}]"
    "#{category_str} -> #{name_str}"
  end
end