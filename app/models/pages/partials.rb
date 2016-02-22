class Pages::Partials < Page
  has_html_block :footer

  def self.disabled
    true
  end
end