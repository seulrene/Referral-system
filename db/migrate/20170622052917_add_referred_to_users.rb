class AddReferredToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :referred, :boolean, default:false
    add_column :users, :user_ref, :string
    add_column :users, :ref_code, :string
  end
end
