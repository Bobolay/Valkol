class Publication < ActiveRecord::Base
  attr_accessible *attribute_names

  globalize :name, :url_fragment, :short_description, :content

  image :avatar, styles: { show: "575x170#" }
  image :banner

  boolean_scope :published
  scope :featured, -> { where(featured: 't').limit(3) }
  scope :order_by_released_at, -> { order("released_at desc") }

  default_scope do
    order_by_released_at
  end

  has_seo_tags
  has_sitemap_record

  def self.default_priority
    0.7
  end

  has_cache do
    pages self, :home, :publications, Publication.published
  end

  has_tags

  before_save :initialize_released_at

  def initialize_released_at
    self.released_at ||= DateTime.now
  end

  def self.get(url_fragment)
    self.published.joins(:translations).where(blog_article_translations: { url_fragment: url_fragment, locale: I18n.locale }).first
  end

  def url(locale = I18n.locale)
    url_fragment = self.translations_by_locale[locale].try(:url_fragment)
    return nil if url_fragment.blank?
    Cms.url_helpers.send("publication_#{locale}_path", id: url_fragment)
  end
end