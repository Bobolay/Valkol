class Pages::Partials < Page
  has_html_block :footer

  def self.disabled
    true
  end

  def cache_instances
    Pages.all_instances
  end
end