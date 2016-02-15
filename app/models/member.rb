class Member < ActiveRecord::Base
  attr_accessible *attribute_names

  has_attached_file :image, styles: { show: "220x260#" }

  scope :published, -> { where(published: 't') }
  scope :sort_by_sorting_position, -> { order("sorting_position asc") }

  %w(image).each do |k|
    do_not_validate_attachment_file_type k
    attr_accessible k, "#{k}_delete"

    allow_delete_attachment(k)
  end

  has_cache
  def cache_instances
    [Pages.about_us]
  end


end
