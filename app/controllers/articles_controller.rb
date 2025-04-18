class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :requaire_user, except: [:show, :index]
  before_action :requaire_same_user, only: [:edit, :update, :destroy]
  def show
  end

  def index 
    @articles = Article.paginate(page: params[:page], per_page: 5).all
  end

  
  def new 
    @article = Article.new
  end

  def edit
  end

  def create 
    @article = Article.new(article_params)
    @article.user = helpers.current_user
    if @article.save
      flash[:notic] = "atricle was created successfully."
      redirect_to articles_path
    else
    puts @article.errors.full_messages.join(", ")
    render "new"
    end
  end

  def update
    if @article.update(article_params)
      flash[:notic] = "atricle was updated successfully."
      redirect_to articles_path
    else
    puts @article.errors.full_messages.join ( " , ")
    render "edit"
    end
  end 
  def destroy
    @article.destroy
    redirect_to articles_path
  end 
  private

    def set_article
      @article = Article.find(params[:id])
    end  
    def article_params
      params.require(:article).permit(:title,:description)
    end  


    def requaire_same_user
      if helpers.current_user != @article.user && !helpers.current_user.admin?
        flash[:alert] = "you can only edit or delet your own article"
        redirect_to @article
      end
  end
end