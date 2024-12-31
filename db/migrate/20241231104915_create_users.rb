class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :email, null: false # Another additional DB way of enforcing email presence
      t.string :password_digest

      t.timestamps
    end
  end
end
