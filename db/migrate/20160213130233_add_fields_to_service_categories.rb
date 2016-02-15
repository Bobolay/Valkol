class AddFieldsToServiceCategories < ActiveRecord::Migration
  def change
    change_table ServiceCategory.table_name do |t|
      t.text :content
      t.integer :sorting_position
    end
  end
end
