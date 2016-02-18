class ApplicationForm < ActiveRecord::Base
  attr_accessible *attribute_names

  has_attached_file :file, styles: { small: "220x260#", large: "700x1000>" }

  scope :published, -> { where(published: 't') }
  scope :sort_by_sorting_position, -> { order("sorting_position asc") }

  %w(file).each do |k|
    do_not_validate_attachment_file_type k
    attr_accessible k, "#{k}_delete"

    allow_delete_attachment(k)
  end

  has_cache
  def cache_instances
    [Pages.pricing]
  end

  def file_icon_name
    if file.exists?

      ext = File.extname(file.path).gsub(/\A\./, '')
      filenames = Dir[Rails.root.join("app/assets/images/filetypes/*.svg")].map{|f| f.split("/").last.gsub(/\.svg/, '') }
      if filenames.include?(ext)
        return "#{ext}.svg"
      else
        return "unknown.svg"
      end
    else
      nil
    end
  end
end
