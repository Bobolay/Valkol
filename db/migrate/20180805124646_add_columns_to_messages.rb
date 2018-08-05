class AddColumnsToMessages < ActiveRecord::Migration
  def change
    change_table :messages do |t|
      t.string :status
      t.datetime :last_time_contacted
      t.text :notes

      t.string :referer
      t.string :session_id
    end

    rename_column :messages, :message_text, :comment
  end
end
