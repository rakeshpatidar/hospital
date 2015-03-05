class CreatePhotomsgs < ActiveRecord::Migration
  def change
    create_table :photomsgs do |t|
      t.integer :physician
      t.integer :patient
      t.string :title
      t.attachment :image

      t.timestamps null: false
    end
  end
end
