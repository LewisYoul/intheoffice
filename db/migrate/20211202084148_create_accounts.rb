class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :user_accounts do |t|
      t.references :user, foreign_key: true
      t.references :account, foreign_key: true
      t.timestamps
    end
  end
end
