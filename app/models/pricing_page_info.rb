class PricingPageInfo < ActiveRecord::Base
  attr_accessible *attribute_names

  globalize :intro, :table, :second_text

  image :banner

  has_cache do
    pages :pricing
  end
end
