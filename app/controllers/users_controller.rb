class RoomsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :show, :update]
  
  def index
    @users = User.all
  end

end