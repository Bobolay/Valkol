def templates_models
  Dir[Rails.root.join("app/models/templates/*")].map{|p| filename = File.basename(p, ".rb"); "Templates::" + filename.camelize }
end

def include_templates_models(config)
  include_models(config, *templates_models)
end


def content_field(name = :content)
  field name, :text do
    help "Якщо редактор не відображається, обновіть сторінку"
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

module RailsAdminDynamicConfig
  class << self
    def configure_rails_admin(initial = true)
      RailsAdmin.config do |config|

        ### Popular gems integration

        ## == Devise ==
        config.authenticate_with do
          warden.authenticate! scope: :user
        end
        config.current_user_method(&:current_user)

        ## == Cancan ==
        #config.authorize_with :cancan

        ## == Pundit ==
        # config.authorize_with :pundit

        ## == PaperTrail ==
        # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

        ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration



        if initial
          config.actions do
            dashboard                     # mandatory
            index do                      # mandatory
              __cms_rails_admin_index_controller
            end
            new do
              except [Message, ApplicationForm]
            end
            export
            bulk_delete
            show
            edit
            delete
            show_in_app
            props do
              only []
            end
            #edit_model
            nestable do
              only [Cms::Page, Service, ServiceCategory, Member, Certificate, ApplicationForm, HomeBanner]
            end

            ## With an audit adapter, you can add:
            # history_index
            # history_show
          end


          config.parent_controller = "ApplicationController"
          config.default_associated_collection_limit = 300
        end

        config.navigation_labels do
          [:feedbacks, :home, :about_us, :services, :pricing, :publications, :interesting_articles, :contacts, :tags, :users, :settings, :pages, :assets]
        end

        config.navigation_static_links = {
            mailchimp: "/admin/mailchimp",
            locales: "/file_editor/locales",
            site_data: "/file_editor/site_data.yml"
        }


        config.include_models Cms::SitemapElement, Cms::MetaTags
        config.include_models Cms::Page
        config.model Cms::Page do
          navigation_label_key(:pages, 1)
          nestable_list({position_field: :sorting_position, scope: :order_by_sorting_position})
          object_label_method do
            :custom_name
            #{
            #k = @bindings[:object].type.underscore.split("/").last
            #I18n.t("activerecord.models.pages.#{k}", raise: true) rescue k.humanize
            #}
          end
          list do
            sort_by do
              "sorting_position"
            end

            field :name do
              def value
                k = @bindings[:object].type.underscore.split("/").last
                I18n.t("activerecord.models.pages.#{k}", raise: true) rescue k.humanize
              end
            end

            field :h1_text do
              def value
                @bindings[:object].h1_text
              end
            end
          end

          edit do
            field :name do
              read_only true
              def value
                k = @bindings[:object].type.underscore.split("/").last
                I18n.t("activerecord.models.pages.#{k}", raise: true) rescue k.humanize
              end
            end

            field :translations, :globalize_tabs

            field :seo_tags

          end

        end

        config.model_translation Cms::Page do
          field :locale, :hidden
          field :h1_text
        end



        config.model Cms::MetaTags do
          visible false
          field :translations, :globalize_tabs
        end

        config.model_translation Cms::MetaTags do
          field :locale, :hidden
          field :title
          field :keywords
          field :description
        end


        config.model Cms::SitemapElement do
          visible false

          field :display_on_sitemap
          field :changefreq
          field :priority
        end

        config.include_models Attachable::Asset


        config.model Attachable::Asset do
          navigation_label_key(:assets, 1)
          field :data
          #watermark_position_field(:data)
          field :sorting_position
          field :translations, :globalize_tabs
        end

        config.model_translation Attachable::Asset do
          field :locale, :hidden
          field :data_alt
        end



        config.include_models User
        config.model User do
          navigation_label_key(:users, 1)
          field :email
          field :password
          field :password_confirmation
        end

        config.include_models Cms::Tag, Cms::Tagging

        config.model Cms::Tag do
          navigation_label_key(:tags, 1)

          tag_categories = [:tags, :pallets, :packings, :product_packaging_types, :office_tags]

          list do
            scopes do
              scopes = {
                all: ->(objects) {
                  objects
                }
              }
              tag_categories.each do |tag_category|
                scopes[tag_category] = ->(objects) {
                  objects.where(category: tag_category)
                }
              end

              scopes[:uncategorized] = ->(objects) {
                objects.where("category IS NULL OR category='' OR category NOT IN (?)", tag_categories)
              }

              scopes
            end

            field :category
            translated_field(:name)
            field :translations do
              visible false
              queryable true
              searchable [:name]
            end
            field :use_times do
              def value
                @bindings[:object].taggings.count
              end
            end

            field :taggable_field_names do
              def value
                @bindings[:object].taggable_field_names.join(', ')
              end
            end
          end

          edit do
            field :category, :enum do
              enum do
                tag_categories
              end
            end
            field :translations, :globalize_tabs
            field :use_times do
              read_only true

              def value
                @bindings[:object].taggings.count
              end
            end
            field :taggables do
              read_only true
              def value
                @bindings[:object].taggings.map(&:taggable).uniq
              end

              pretty_value do
                v = bindings[:view]
                [value].flatten.select(&:present?).collect do |record|
                  #amc = polymorphic? ? RailsAdmin.config(associated) : associated_model_config # perf optimization for non-polymorphic associations
                  #am = amc.abstract_model
                  amc = RailsAdmin.config(record.class)
                  am = amc.abstract_model
                  wording = record.send(amc.object_label_method)
                  can_see = !am.embedded? && (show_action = v.action(:show, am, record))
                  can_see ? v.link_to(wording, v.url_for(action: show_action.action_name, model_name: am.to_param, id: record.id), class: 'pjax') : ERB::Util.html_escape(wording)
                end.to_sentence.html_safe
              end
            end
            field :taggable_field_names do
              read_only true

              pretty_value do
                value.join(', ')
              end
            end
          end
          #field :videos
        end


        config.model_translation Cms::Tag do
          field :locale, :hidden
          field :name
          field :url_fragment do
            help do
              I18n.t("admin.help.#{name}")
            end
          end
        end


        config.model Cms::Tagging do
          visible false
        end

        # ===================================================
        # Requests
        # ===================================================
        config.configure_forms(:all)

        # ===================================================
        # Application specific models
        # ===================================================

        # Include models

        config.model Publication do
          navigation_label_key :publications
          field :published
          field :featured
          field :translations, :globalize_tabs
          field :avatar
          field :banner
          field :tags
          field :seo_tags
        end

        config.model_translation Publication do
          field :name
          field :url_fragment
          field :content, :ck_editor
        end

        config.model InterestingArticle do
          navigation_label_key :interesting_articles

          field :published
          field :featured
          field :translations, :globalize_tabs
          field :avatar
          field :banner
          field :tags
          field :seo_tags
        end

        config.model_translation InterestingArticle do
          field :name
          field :url_fragment
          field :content, :ck_editor
        end

        config.model Service do
          navigation_label_key :services, 1
          nestable_list(position_field: :sorting_position)

          field :published
          field :service_category
          field :avatar
          field :banner
          field :translations, :globalize_tabs
          field :seo_tags
        end

        config.model_translation Service do
          field :name
          field :url_fragment
          field :short_description
          field :content, :ck_editor
        end

        config.model ServiceCategory do
          navigation_label_key :services, 2
          nestable_list(position_field: :sorting_position)

          field :published
          field :translations, :globalize_tabs
        end

        config.model_translation ServiceCategory do
          field :name
          field :url_fragment
          content_field
        end

        config.model Member do
          navigation_label_key :about_us, 1
          nestable_list(position_field: :sorting_position)

          field :published
          field :position
          field :image
          field :translations, :globalize_tabs
        end

        config.model_translation Member do
          field :name
          field :position
          field :description
        end

        config.model Certificate do
          navigation_label_key :about_us, 1
          nestable_list(position_field: :sorting_position)

          field :published
          field :image
          field :translations, :globalize_tabs
        end

        config.model_translation Certificate do
          field :name
        end

        config.model ApplicationForm do
          navigation_label_key :pricing, 1
          nestable_list(position_field: :sorting_position)

          field :published
          field :translations, :globalize_tabs
          field :file
        end

        config.model_translation ApplicationForm do
          field :name
        end

        config.model Message do
          navigation_label_key :feedbacks, 1

          list do
            scopes do
              [:all, *Message::STATUSES]
            end

            field :status
            field :name
            field :phone
            field :email
            field :last_time_contacted
            field :comment
          end

          edit do
            field :status
            field :name do
              read_only true
            end
            field :phone do
              read_only true
            end
            field :email do
              read_only true
            end
            field :comment do
              read_only true
            end

            field :notes
            field :last_time_contacted
          end
        end

        config.model HomeBanner do
          navigation_label_key :home, 1
          nestable_list(position_field: :sorting_position)

          edit do
            field :published
            field :image
            linkable_field([Cms::Page, ServiceCategory, Service, Publication, InterestingArticle], :linkable, sort_by_path: true)
            field :translations, :globalize_tabs
          end
        end

        config.model_translation HomeBanner do
          field :name
          field :description
        end

        config.model HomePageInfo do
          navigation_label_key :home, 2

          field :translations, :globalize_tabs
        end

        config.model_translation HomePageInfo do
          field :about_text, :ck_editor
        end

        config.model AboutUsPageInfo do
          navigation_label_key :about_us, 1

          field :banner
          field :translations, :globalize_tabs
        end

        config.model_translation AboutUsPageInfo do
          field :history, :ck_editor
          field :experience, :ck_editor
          field :team, :ck_editor
        end

        config.model PricingPageInfo do
          navigation_label_key :pricing

          field :banner
          field :translations, :globalize_tabs
        end

        config.model_translation PricingPageInfo do
          field :intro, :ck_editor
          field :table, :ck_editor
          field :second_text, :ck_editor
        end
      end
    end
  end
end