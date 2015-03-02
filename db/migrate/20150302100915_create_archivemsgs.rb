class CreateArchivemsgs < ActiveRecord::Migration
  def change
    create_table :archivemsgs do |t|
      t.text :text_msg
      t.string :physician_name
      t.string :patient_name
      t.integer :physician
      t.integer :patient
      	
      t.timestamps null: false
    end
  end
end
