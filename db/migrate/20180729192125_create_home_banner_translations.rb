class CreateHomeBannerTranslations < ActiveRecord::Migration
  def change
    create_translation_table(HomeBanner, :name, :description)
  end
end
