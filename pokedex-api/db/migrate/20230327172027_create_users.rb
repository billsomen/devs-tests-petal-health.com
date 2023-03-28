class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :user_role
      t.string :user_id
      t.string :role_id
      t.string :password_digest

      t.timestamps
    end
  end
end
