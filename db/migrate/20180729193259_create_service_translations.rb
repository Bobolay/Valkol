class CreateServiceTranslations < ActiveRecord::Migration
  def change
    create_translation_table(Service, :name, :short_description, :content)
  end
end
