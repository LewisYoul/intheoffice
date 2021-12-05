class CreateRoles < ActiveRecord::Migration[6.1]
  def change
    create_table :roles do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_reference :user_accounts, :role
  end
end
