class CreateApplicationFormTranslations < ActiveRecord::Migration
  def change
    create_translation_table(ApplicationForm, :name)
  end
end
