class Referral < ApplicationRecord
  belongs_to :user
  validates :referral_email, presence: true, uniqueness: {scope: :user_id}
end
