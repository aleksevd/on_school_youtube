class CreateTinymceImages < ActiveRecord::Migration[5.1]
  def change
    create_table :tinymce_images do |t|
      t.string :file
      t.references :owner, polymorphic: true, index: true

      t.timestamps
    end
  end
end
