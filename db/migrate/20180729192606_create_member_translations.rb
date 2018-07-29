class CreateMemberTranslations < ActiveRecord::Migration
  def change
    create_translation_table(Member, :name, :position, :description)
  end
end
