class UsersController < ApplicationController
before_action :set_user, only:[:show, :edit, :update, :destroy]
before_action :requaire_same_user, only: [:edit, :update, :destroy ]

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 4).all
  end  

  def index 
    @users= User.paginate(page: params[:page], per_page: 2).all
    
  end

  def new 
    @user = User.new
  end 
  
  def edit
  end  

  def update
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
      session[:user_id] = @user.id
      flash[:notic] = "welcome to the Alpha Blog #{@user.username}, you have successfully sign up."
      redirect_to articles_path
    else
    render "new"
    end
  end 
  
  def destroy
  @user.destroy  
  session[:user_id] = nil if @user == helpers.current_user
  flash[:notic] = "Account and all associated articles successfully deleted"
  redirect_to articles_path
  end   


  
  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end  

  def set_user
    @user = User.find(params[:id])

  end

  def requaire_same_user
    if helpers.current_user != @user && !helpers.current_user.admin?
      flash[:alert] = "you can only edit or delet your own article"
      redirect_to @user
    end
  end  
end  