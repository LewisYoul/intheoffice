class AddNoteToUserAccountLocations < ActiveRecord::Migration[6.1]
  def change
    add_column :user_account_locations, :note, :string
  end
end
