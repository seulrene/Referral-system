class CreateTableReferrals < ActiveRecord::Migration[5.1]
  def change
    create_table :referrals do |t|
      t.string :referral_email
      t.boolean :status
      t.timestamps
    end
    add_column :referrals, :user_id, :string
    add_index :referrals, :user_id
  end
end
