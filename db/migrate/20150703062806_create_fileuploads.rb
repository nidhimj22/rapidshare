class CreateFileuploads < ActiveRecord::Migration
  def change
    create_table :fileuploads do |t|
      t.text :file_name
      t.text :file_path

      t.timestamps null: false
    end
  end
end
