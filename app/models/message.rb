class Message < ActiveRecord::Base
  extend Enumerize

  attr_accessible *attribute_names

  STATUSES = [:unprocessed, :rejected, :in_progress, :done]

  enumerize :status, in: STATUSES, default: :unprocessed

  STATUSES.each do |status|
    scope status, -> { where(status: status) }
  end

  include Cms::Notifier

  validates_presence_of :name, :phone, :email, :comment, :referer

  extend Cms::FormAttributesHelper

  def self.fields_from_model
    self.form_attributes(true)
  end
end
