class CreatePhotomsgs < ActiveRecord::Migration
  def change
    create_table :photomsgs do |t|
      t.integer :physician
      t.integer :patient_id
      t.attachment :image

      t.timestamps null: false
    end
  end
end
