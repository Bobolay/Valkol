class CreateCmsTables < ActiveRecord::Migration
  def change
    Cms.create_tables
  end
end
