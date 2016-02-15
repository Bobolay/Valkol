class Article < ActiveRecord::Base
  acts_as_article(tags: true, initialize_all_attachments: false, author: false)

  [:avatar].each do |attachment_name|
    has_attached_file attachment_name, styles: { show: "575x170#" }
    do_not_validate_attachment_file_type attachment_name
    attr_accessible attachment_name
    allow_delete_attachment attachment_name
  end

  has_cache
  def cache_instances
    public_fields = [:tags, :name, :url_fragment, :avatar, :released_at, :featured]
    any_public_field_changed = public_fields.map{|f| method = "#{f}_changed?"; self.respond_to?(method) && send(method) }.select(&:present?).any?

    if any_public_field_changed
      [Pages.home, Pages.publications, Pages.interesting_articles, Article.all]
    else
      [self]
    end
  end

  def comments_count
    "124 коментаря"
  end


end