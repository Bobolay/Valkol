class AddUrlFragmentToServiceTranslations < ActiveRecord::Migration
  def change
    add_column :service_translations, :url_fragment, :string
  end
end
