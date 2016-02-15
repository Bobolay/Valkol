def pages_models
  Dir[Rails.root.join("app/models/pages/*")].map{|p| filename = File.basename(p, ".rb"); "Pages::" + filename.camelize }
end

def templates_models
  Dir[Rails.root.join("app/models/templates/*")].map{|p| filename = File.basename(p, ".rb"); "Templates::" + filename.camelize }
end

def include_pages_models(config)
  include_models(config, *pages_models)
end

def include_templates_models(config)
  include_models(config, *templates_models)
end

def include_models(config, *models)
  models.each do |model|
    config.included_models += [model]

    if !model.instance_of?(Class)
      Dir[Rails.root.join("app/models/#{model.underscore}")].each do |file_name|
        require file_name
      end

      model = model.constantize rescue nil
    end

    if model.respond_to?(:translates?) && model.translates?
      config.included_models += [model.translation_class]
    end
  end
end



def content_field(name = :content)
  field name, :text do
    html_attributes do
      {
          class: "my-codemirror",
          mode: "slim"
      }
    end

    def value
      bindings[:object].send(name)
    end
  end
end

def pages_navigation_label
  navigation_label do
    I18n.t("admin.navigation_labels.pages")
  end
end

def settings_navigation_label
  navigation_label do
    "Settings"
  end
end

def forms_navigation_label
  navigation_label do
    "Forms"
  end
end

def page_fields(hide_content = false)
  #configure_codemirror_html_field(:content)
  field :banner
  content_field  if !hide_content


  html_block_fields
  field :url
  field :seo_tags
  field :sitemap_record
end

def configure_codemirror_html_field(name)
  configure name, :code_mirror do
    theme = "night" # night
    mode = 'css'

    assets do
      {
          mode: "/assets/codemirror/modes/#{mode}.js",
          theme: "/assets/codemirror/themes/#{theme}.css",
      }
    end

    config do
      {
          mode: mode,
          theme: theme,
      }
    end
  end
end

def configure_html_blocks
  m = self.abstract_model.model
  if m.respond_to?(:html_block_field_names)

    m.html_block_field_names.each do |name|

    end
  end
end

def html_block_fields
  m = self.abstract_model.model
  if m.respond_to?(:html_block_field_names)

    m.html_block_field_names.each do |name|
      content_field name.to_sym
    end
  end
end


RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show

    nestable do
      only [Service, ServiceCategory, Member, Certificate]
    end
  end

  include_models(config, Cms::MetaTags)
  include_pages_models(config)
  include_models(config, Publication, InterestingArticle, Service, ServiceCategory, Member, Certificate)

  config.model Cms::MetaTags do
    visible false

    field :title
    field :keywords
    field :description
  end

  config.model Pages::Home do
    field :seo_tags
  end

  config.model Pages::AboutUs do
    content_field(:history)
    content_field(:experience)
    content_field(:team)

    field :seo_tags
  end

  config.model Pages::Pricing do
    field :seo_tags
  end

  config.model Pages::Contacts do
    field :seo_tags
  end

  config.model Pages::Services do
    field :seo_tags
  end

  config.model Pages::Publications do
    field :seo_tags
  end

  config.model Pages::InterestingArticles do
    field :seo_tags
  end

  [Publication, InterestingArticle].each do |m|
    config.model m do
      field :published
      field :featured
      field :name
      field :url_fragment
      content_field
      field :avatar
    end
  end

  config.model Service do
    nestable_list(position_field: :sorting_position)

    field :published
    field :name
    field :url_fragment
    field :service_category
    content_field
  end

  config.model ServiceCategory do
    nestable_list(position_field: :sorting_position)

    field :published
    field :name
    field :url_fragment
    content_field
  end

  config.model Member do
    nestable_list(position_field: :sorting_position)

    field :published
    field :name
    field :position
    field :image
    field :description

  end

  config.model Certificate do
    nestable_list(position_field: :sorting_position)

    field :published
    field :name
    field :image
  end
end
