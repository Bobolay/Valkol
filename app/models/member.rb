class Member < ActiveRecord::Base
  attr_accessible *attribute_names

  globalize :name, :position, :description

  image :image, styles: { show: "220x260#" }

  boolean_scope :published
  scope :sort_by_sorting_position, -> { order(sorting_position: :asc) }

  has_cache do
    pages :about_us
  end


end
