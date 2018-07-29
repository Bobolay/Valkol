class CreateInterestingArticles < ActiveRecord::Migration
  def change
    create_table :interesting_articles do |t|
      t.boolean :published
      t.boolean :featured
      t.string :name
      t.string :url_fragment
      t.text :short_description
      t.text :content
      t.datetime :released_at

      t.image :avatar
      t.image :banner
    end

    create_translation_table(InterestingArticle, :name, :url_fragment, :short_description, :content)
  end
end
