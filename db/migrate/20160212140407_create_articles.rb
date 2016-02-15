class CreateArticles < ActiveRecord::Migration
  def up
    Article.create_article_table

    change_table Article.table_name do |t|
      t.string :type
      t.boolean :featured
      t.datetime :released_at
    end
  end

  def down
    Article.drop_article_table
  end
end
