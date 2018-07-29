class CreateCertificateTranslations < ActiveRecord::Migration
  def change
    create_translation_table(Certificate, :name)
  end
end
