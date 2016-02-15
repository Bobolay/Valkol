class AddFieldsToServices < ActiveRecord::Migration
  def change
    change_table Service.table_name do |t|
      t.integer :sorting_position
    end
  end
end
