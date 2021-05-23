class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.text :email
      t.text :department
      t.text :password_digest
      t.text :image_url
      t.text :name

      t.timestamps
    end
  end
end
