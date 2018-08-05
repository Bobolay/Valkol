class ServiceCategory < ActiveRecord::Base
  attr_accessible *attribute_names

  globalize :name, :url_fragment, :content

  has_many :services
  attr_accessible :services, :service_ids

  has_cache do
    pages self, :about_us, :contacts, :home, :interesting_articles, :pricing, :publications, :services, Service.published, InterestingArticle.published, Publication.published
  end

  scope :sort_by_sorting_position, -> { order(sorting_position: :asc) }
  scope :published, -> { where(published: 't') }
  scope :with_translated_services, -> do
    joins(:services).merge(Service.published.translated)
  end
  default_scope do
    sort_by_sorting_position
  end

  def url(locale = I18n.locale)
    return nil if url_fragment.blank?

    url_helpers.send("services_#{locale}_path") + "##{url_fragment}"
  end

  def linkable_path
    name_str = name.presence || "[ServiceCategory ##{id}]"
    "#{name_str}"
  end

  def public_services
    services.published.translated.sort_by_sorting_position.uniq
  end
end