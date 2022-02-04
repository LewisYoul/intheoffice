class CreatePlansAndSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :plans do |t|
      t.string :level, null: false
      t.integer :monthly_cost_dollars, null: false
      t.integer :yearly_cost_dollars, null: false
      t.string :stripe_price_id, null: false

      t.timestamps
    end

    create_table :subscriptions do |t|
      t.references :plan
      t.references :account
      t.boolean :auto_renew, null: false
      t.datetime :start_datetime, null: false
      t.datetime :end_datetime, null: false
      t.boolean :active, null: false
      t.string :stripe_subscription_id

      t.timestamps
    end

    add_column :accounts, :auto_renew, :boolean, default: true, null: false
  end
end
