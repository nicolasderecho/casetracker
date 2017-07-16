class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    authorize(@user)
    render json: { data: @user.serialized }
  end

  def edit
    @user = User.find(params[:id])
    authorize(@user)
    render json: { data: @user.serialized }
  end

  def update
    @user = User.find(params[:id])
    authorize(@user)
    if @user.update_attributes(user_params)
      render json: { data: @user.serialized, notice: I18n.t("flash.updated_profile") }, status: 200
    else
      render json: { data: @user.serialized }, status: 422
    end
  end

  def change_password
    @user = current_user
    render json: @user
  end

  def update_password
    @user = current_user
    authorize @user
    if @user.update_attributes(password_params)
      render json: { data: @user.serialized, notice: I18n.t("flash.password_update_success") }, status: 200
    else
      render json: { data: @user.serialized }, status: 422
    end
  end


  private
    def user_params
      params[:user].permit(:first_name, :last_name, :avatar, :avatar_cache)
    end

    def password_params
      params[:user].permit(:password, :password_confirmation)
    end


end
