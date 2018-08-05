class CreateContactsPageInfos < ActiveRecord::Migration
  def change
    create_table :contacts_page_infos do |t|
      t.text :phones
      t.text :fax_phones
      t.text :skype_names
      t.text :emails
      t.text :address

      t.timestamps null: false
    end

    create_translation_table(ContactsPageInfo, :address)
  end
end
