require 'rails_admin_extensions/scopes'
require_relative 'require_lib'

def image_field(name = :image, &block)
  field name do
    pretty_value do
      if value.presence
        v = bindings[:view]
        url = resource_url
        if image
          thumb_url = resource_url(thumb_method)
          image_html = v.image_tag(thumb_url, class: 'img-thumbnail', style: "max-width: 100px")
          url != thumb_url ? v.link_to(image_html, url, target: '_blank') : image_html
        else
          v.link_to(nil, url, target: '_blank')
        end
      end
    end


    if block
      self.instance_eval(&block)
      #block.call
    end
  end
end


RailsAdminDynamicConfig.configure_rails_admin