class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.boolean :published
      t.integer :sorting_position
      t.attachment :image
      t.string :name
      t.text :description
      t.string :position

      t.timestamps null: false
    end
  end
end
