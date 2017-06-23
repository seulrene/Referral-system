class ReferController < ApplicationController
  before_action :authenticate_user!
  def index
    @history = User.where(ref_code: current_user.user_ref)
  end
end
