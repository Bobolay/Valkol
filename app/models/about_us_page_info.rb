class AboutUsPageInfo < ActiveRecord::Base
  attr_accessible *attribute_names

  globalize :history, :experience, :team

  has_cache do
    pages :about_us
  end

  image :banner
end
