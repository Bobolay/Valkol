class Certificate < ActiveRecord::Base
  attr_accessible *attribute_names

  globalize :name

  image :image, styles: { small: "220x260#", large: "700x1000>" }

  boolean_scope :published
  scope :sort_by_sorting_position, -> { order(sorting_position: :asc) }
  default_scope do
    sort_by_sorting_position
  end

  has_cache do
    pages :home, :about_us
  end
end
