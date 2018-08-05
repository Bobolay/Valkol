class AddCertificatesDescriptionToHomePageInfos < ActiveRecord::Migration
  def change
    add_column :home_page_infos, :certificates_description, :text
    add_column :home_page_info_translations, :certificates_description, :text
  end
end
