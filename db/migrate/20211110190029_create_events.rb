class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.date :event_date, null: false
      t.references :user, null: false
      t.references :account, null: false

      t.timestamps
    end
  end
end
