module ApplicationHelper
  def main_menu
    #brands_children = @menu_featured_brands.map{|b| {name: raw(b.name), active: false, url: b.url, resource: b } }
    recursive_menu([
       "about_us",
       {
         key: :services,
         active: action_name == 'index' && controller_name == "services",
         has_active: action_name != 'index' && controller_name == "services"
       },
       "pricing",
       {
         key: :publications,
         active: action_name == 'index' && (controller_name == "publications" || controller_name == 'interesting_articles'),
         has_active: action_name != 'index' && (controller_name == "publications" || controller_name == 'interesting_articles')
       },
       :contacts
     ])
  end
end
