class CreateParticipants < ActiveRecord::Migration[6.1]
  def change
    create_table :participants do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :full_name, null: false
      t.string :email
      t.references :account, null: false
      t.references :user, null: false

      t.timestamps
    end
  end
end
