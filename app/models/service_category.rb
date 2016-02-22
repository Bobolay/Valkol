class ServiceCategory < ActiveRecord::Base
  attr_accessible *attribute_names

  has_many :services
  attr_accessible :services, :service_ids

  has_cache
  def cache_instances
    Pages.all_instances
  end

  before_validation :initialize_url_fragment

  scope :sort_by_sorting_position, -> { order("sorting_position asc") }
  scope :published, -> { where(published: 't') }

  def url
    url_helpers.send("services_path") + "##{self.url_fragment}"
  end
end