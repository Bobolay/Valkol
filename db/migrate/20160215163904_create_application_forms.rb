class CreateApplicationForms < ActiveRecord::Migration
  def change
    create_table :application_forms do |t|
      t.string :name
      t.attachment :file
      t.boolean :published
      t.integer :sorting_position

      t.timestamps
    end
  end
end
