class AddFullNameToUsers < ActiveRecord::Migration[6.1]
  def up
    add_column :users, :full_name, :string

    User.find_each(&:save!)

    change_column_null :users, :full_name, false
  end

  def down
    remove_column :users, :full_name
  end
end
