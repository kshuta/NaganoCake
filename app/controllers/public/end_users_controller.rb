class Public::EndUsersController < ApplicationController
  def index
  end

  def show
    @user = current_end_user
  end

  def edit
    @user = current_end_user
  end

  def update
    user = current_end_user 
    if user.update(user_params)
      redirect_to end_users_path
    else 
      @user = user 
      render :edit
    end
  end

  def confirm
  end

  # def destroy
  #   sessions_controller = Devise::RegistrationsController
  #   sessions_controller.destroy
  #   user = current_end_user 
  #   user.is_registered = 0
  #   user.save
  #   user.destroy

  # end

  private
  def user_params
    params.require(:end_user).permit(:email, :last_name_kanji, :first_name_kanji, :last_name_kana, :first_name_kana, :zip_code, :address, :phone_number)
  end

end
