class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name
      t.text :password_hash

      t.timestamps null: false
    end
  end
end
