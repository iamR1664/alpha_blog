class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @articles = @user.articles.paginate(page: params[:page], per_page: 4).all
  end  

  def index 
    @users= User.paginate(page: params[:page], per_page: 2).all
    
  end

  def new 
    @user = User.new
  end 
  
  def edit
    @user = User.find(params[:id])
  end  

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notic] = "your accont information was updated successfully."
      redirect_to @user
    else
      render "edit"
    end  
  end 

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notic] = "welcome to the Alpha Blog #{@user.username}, you have successfully sign up."
      redirect_to articles_path
    else
    render "new"
    end
  end 
  
  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end  
end  