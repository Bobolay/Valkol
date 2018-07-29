class CreatePricingPageInfos < ActiveRecord::Migration
  def change
    create_table :pricing_page_infos do |t|
      t.image :banner
      t.text :intro
      t.text :table
      t.text :second_text

      t.timestamps null: false
    end

    create_translation_table PricingPageInfo, :intro, :table, :second_text
  end
end
