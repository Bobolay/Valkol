class HomeBanner < ActiveRecord::Base
  attr_accessible *attribute_names

  has_attached_file :image, styles: { small: "192x108#", large: "1920x1080#" }

  scope :published, -> { where(published: 't') }
  scope :sort_by_sorting_position, -> { order("sorting_position asc") }

  %w(image).each do |k|
    do_not_validate_attachment_file_type k
    attr_accessible k, "#{k}_delete"

    allow_delete_attachment(k)
  end

  has_cache
  def cache_instances
    [Pages.home]
  end

  def url
    self['url']
  end
end
