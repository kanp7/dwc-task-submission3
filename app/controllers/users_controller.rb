class UsersController < ApplicationController

	before_action :authenticate_user!
  before_action :correct_user, only:[:edit, :update]


  def show
  	@user = User.find(params[:id])
  	@book = Book.new
  	@books = @user.books
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
    	redirect_to user_path(@user.id)
    else
      render "edit"
    end
  end

  def index
  	@users = User.all
  	@user = User.find(current_user.id)
  	@book = Book.new
  end

  def following
    @title = "Follow Users"
    @user = User.find(params[:id])
    @users = @user.following.all
    render 'show_follow'
  end

  def followers
    @title = "Follower Users"
    @user = User.find(params[:id])
    @users = @user.followers.all
    render 'show_follow'
  end

  private

  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image,
           :postcode, :prefecture_name, :address_city, :addres_street, :latitude, :longitude)
  end

  def correct_user
    user = User.find(params[:id])
      if current_user != user
        redirect_to user_path(current_user)
      end
  end


end
