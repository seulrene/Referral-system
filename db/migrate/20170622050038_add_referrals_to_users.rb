class AddReferralsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :total_referral, :integer, default: 3
    add_column :users, :referrals, :integer, default: 0
    add_column :users, :amount, :integer, default: 0
  end
end
