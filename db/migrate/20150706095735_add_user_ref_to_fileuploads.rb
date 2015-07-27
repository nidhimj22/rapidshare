class AddUserRefToFileuploads < ActiveRecord::Migration
  def change
    add_reference :fileuploads, :user, index: true, foreign_key: true
  end
end
