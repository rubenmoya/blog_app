class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new article_params

    if @article.save
      redirect_to articles_path, :flash => { :success => "Article has been created" }
    else
      flash.now[:danger] = "Article has not been created"
      render 'new'
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article, :flash => { :success => "Article has been updated" }
    else
      flash.now[:danger] = "Article has not been updated"
      render 'edit'
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def destroy
    @article = Article.find(params[:id])
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
end
