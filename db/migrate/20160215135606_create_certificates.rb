class CreateCertificates < ActiveRecord::Migration
  def change
    create_table :certificates do |t|
      t.string :name
      t.attachment :image
      t.boolean :published
      t.integer :sorting_position

      t.timestamps
    end
  end
end
