class AddBannerToServices < ActiveRecord::Migration
  def change
    change_table :services do |t|
      t.image :banner
    end
  end
end
