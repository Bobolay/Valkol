class ServiceCategory < ActiveRecord::Base
  attr_accessible *attribute_names

  globalize :name, :url_fragment, :content

  has_many :services
  attr_accessible :services, :service_ids

  has_cache do
    pages :about_us, :contacts, :home, :interesting_articles, :pricing, :publications, :services
  end

  scope :sort_by_sorting_position, -> { order("sorting_position asc") }
  scope :published, -> { where(published: 't') }

  def url(locale = I18n.locale)
    return nil if url_fragment.blank?

    url_helpers.send("services_#{locale}_path") + "##{url_fragment}"
  end

  def linkable_path
    name_str = name.presence || "[ServiceCategory ##{id}]"
    "#{name_str}"
  end
end