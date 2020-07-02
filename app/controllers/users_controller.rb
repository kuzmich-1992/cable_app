class RoomsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :show, :update]
  
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to action: :index
    else
      render 'validation error'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to action: :index
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'user was destroyed.' }
      format.json { head :no_content }
    end
  end


  private

  def user_params
    params.require(:user).permit(:username, :email)
  end
end