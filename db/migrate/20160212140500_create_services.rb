class CreateServices < ActiveRecord::Migration
  def up
    Service.create_article_table
    change_table Service.table_name do |t|
      t.belongs_to :service_category
    end
  end

  def down
    Service.drop_article_table
  end
end
