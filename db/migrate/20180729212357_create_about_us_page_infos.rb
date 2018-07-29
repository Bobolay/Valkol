class CreateAboutUsPageInfos < ActiveRecord::Migration
  def change
    create_table :about_us_page_infos do |t|
      t.image :banner
      t.text :history
      t.text :experience
      t.text :team

      t.timestamps null: false
    end

    create_translation_table AboutUsPageInfo, :history, :experience, :team
  end
end
