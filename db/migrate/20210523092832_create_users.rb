class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :department
      t.string :password_digest
      t.text :image_url
      t.string :name

      t.timestamps
    end
  end
end