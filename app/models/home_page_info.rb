class HomePageInfo < ActiveRecord::Base
  attr_accessible *attribute_names
  globalize :about_text, :certificates_description

  has_cache do
    pages :home
  end
end
