class ApplicationForm < ActiveRecord::Base
  attr_accessible *attribute_names

  globalize :name

  pdf :file, styles: { small: "220x260#", large: "700x1000>" }

  boolean_scope :published
  scope :sort_by_sorting_position, -> { order("sorting_position asc") }
  default_scope do
    sort_by_sorting_position
  end

  has_cache do
    pages :pricing
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
