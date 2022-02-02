class CreatePlansAndSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :plans do |t|
      t.string :level, null: false
      t.integer :monthly_cost, null: false
      t.integer :yearly_cost, null: false

      t.timestamps
    end

    create_table :subscriptions do |t|
      t.references :plan
      t.references :account
      t.date :start_date, null: false
      t.date :end_date, null: false

      t.timestamps
    end

    add_column :accounts, :auto_renew, :boolean, default: true, null: false
  end
end
