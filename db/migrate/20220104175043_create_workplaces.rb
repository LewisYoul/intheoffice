class CreateWorkplaces < ActiveRecord::Migration[6.1]
  def change
    create_table :workplaces do |t|
      t.string :name, null: false
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end

    add_reference :user_accounts, :workplace
  end
end
