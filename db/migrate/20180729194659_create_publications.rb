class CreatePublications < ActiveRecord::Migration
  def change
    create_table :publications do |t|
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

    create_translation_table(Publication, :name, :url_fragment, :short_description, :content)
  end
end
