class CreateUserAccountLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :locations do |t|
      t.string :name, null: false

      t.timestamps
    end

    create_table :user_account_locations do |t|
      t.references :user_account, null: false, foreign_key: true
      t.references :location, null: false, foreign_key: true
      t.date :location_date, null: false

      t.timestamps
    end
  end
end
