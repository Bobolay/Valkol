class CreateHomeBanners < ActiveRecord::Migration
  def change
    create_table :home_banners do |t|
      t.string :name
      t.text :description
      t.attachment :image
      t.string :url
      t.integer :sorting_position
      t.boolean :published

      t.timestamps
    end
  end
end
