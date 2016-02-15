class ServiceCategory < ActiveRecord::Base
  attr_accessible *attribute_names

  has_many :services
  attr_accessible :services, :service_ids

  has_cache
  def cache_instances
    public_fields = [:name, :url_fragment]
    any_public_field_changed = public_fields.map{|f| method = "#{f}_changed?"; self.respond_to?(method) && send(method) }.select(&:present?).any?

    if any_public_field_changed
      Pages.all_instances
    else
      [self]
    end
  end

  before_validation :initialize_url_fragment

  scope :sort_by_sorting_position, -> { order("sorting_position asc") }
  scope :published, -> { where(published: 't') }
end