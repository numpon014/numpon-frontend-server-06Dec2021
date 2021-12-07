class AddProfileToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string, after: :password_digest
    add_column :users, :avatar, :string, after: :name
    add_column :users, :age, :integer, after: :avatar
  end
end
