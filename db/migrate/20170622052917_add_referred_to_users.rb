class AddReferredToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :referred, :boolean, default:false
  end
end
