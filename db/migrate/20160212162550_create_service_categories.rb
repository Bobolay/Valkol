class CreateServiceCategories < ActiveRecord::Migration
  def change
    create_table :service_categories do |t|
      t.string :name
      t.string :url_fragment
      t.boolean :published
    end
  end
end
