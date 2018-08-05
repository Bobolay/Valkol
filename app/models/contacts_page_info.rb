class ContactsPageInfo < ActiveRecord::Base
  attr_accessible *attribute_names

  globalize :address

  line_separated_field :phones
  line_separated_field :fax_phones
  line_separated_field :skype_names
  line_separated_field :emails
  line_separated_field :address

  has_cache do
    pages :contacts
  end
end
