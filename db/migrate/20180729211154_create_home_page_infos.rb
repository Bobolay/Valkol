class CreateHomePageInfos < ActiveRecord::Migration
  def change
    create_table :home_page_infos do |t|
      t.text :about_text

      t.timestamps null: false
    end

    create_translation_table(HomePageInfo, :about_text)
  end
end
