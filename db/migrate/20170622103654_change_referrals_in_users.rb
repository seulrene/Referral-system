class ChangeReferralsInUsers < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :referrals, :no_of_referrals
  end
end
