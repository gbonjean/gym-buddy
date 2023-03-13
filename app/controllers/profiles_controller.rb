class ProfilesController < ApplicationController

  def show
    @user = current_user
  end

  def locale_update
    case current_user.locale
    when "fr"
      current_user.locale = "en"
      current_user.save!
    when "en"
      current_user.locale = "fr"
      current_user.save!
    end
    redirect_to profile_path(current_user)
  end
end
