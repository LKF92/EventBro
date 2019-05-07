class UsersController < ApplicationController
  before_action :authenticate_user, except: [:new, :create]
  before_action :not_your_profile, except: [:new, :create]

  def new
  end

  def show
    @user = User.find(params[:id])

  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def authenticate_user
    unless current_user
      flash[:danger] = "Please log in."
      redirect_to new_user_session_path
    end
  end

  def not_your_profile
      redirect_to root_path if current_user != User.find(params[:id])
  end


end
