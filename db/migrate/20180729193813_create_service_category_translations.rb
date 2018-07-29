class CreateServiceCategoryTranslations < ActiveRecord::Migration
  def change
    create_translation_table(ServiceCategory, :name, :url_fragment, :content)
  end
end
