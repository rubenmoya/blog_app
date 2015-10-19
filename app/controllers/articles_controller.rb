class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.all
  end

  def show
    @comment = @article.comments.build
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.build article_params

    if @article.save
      redirect_to articles_path, :flash => { :success => "Article has been created" }
    else
      flash.now[:danger] = "Article has not been created"
      render 'new'
    end
  end

  def edit
    if @article.user != current_user
      redirect_to root_path, :flash => { :danger => "You can only edit your own articles." }
    end
  end

  def update
    if @article.user != current_user
      redirect_to root_path, :flash => { :danger => "You can only edit your own articles." }
    else
      if @article.update(article_params)
        redirect_to @article, :flash => { :success => "Article has been updated" }
      else
        flash.now[:danger] = "Article has not been updated"
        render 'edit'
      end
    end
  end

  def destroy
    if @article.destroy
      redirect_to articles_path, :flash => { :success => "Article has been deleted" }
    else
      redirect_to @article, :flash => { :danger => "Article has not been deleted" }
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end

  def set_article
    @article = Article.find(params[:id])
  end
end
