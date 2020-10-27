class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new
    @article.title = params[:title]
    @article.description = params[:description]
    @article.save
    redirect_to article_path(@article)
  end
  def edit 
    @article = Article.find(params[:id])
  end
  def update
    @article = Article.find(params[:id])
  @article.update(title: params[:article][:title], description: params[:article][:description])
  redirect_to article_path(@article)
  end
  
  DRYing up Strong Params
The code we wrote above is great if you only have a create method in your controller. However, if you have a standard CRUD setup you will also need to implement the same code in your update action. In our example we had different code for create and update, but generally you have the same items. It's a standard Rails practice to remove code repetition, so let's abstract the strong parameter call into its own method in the controller:

# app/controllers/posts_controller.rb

# def create
#   @post = Post.new(post_params)
#   @post.save
#   redirect_to post_path(@post)
# end

# def update
#   @post = Post.find(params[:id])
#   @post.update(post_params)
#   redirect_to post_path(@post)
# end

# private

# def post_params
#   params.require(:post).permit(:title, :description)
# end 
  # add edit and update methods here
  # def create
  #   @post = Post.new(post_params(:title, :description))
  #   @post.save
  #   redirect_to post_path(@post)
  # end
  
  # def update
  #   @post = Post.find(params[:id])
  #   @post.update(post_params(:title))
  #   redirect_to post_path(@post)
  # end
  
  # private
  
  
  # # We pass the permitted fields in as *args;
  # # this keeps `post_params` pretty dry while
  # # still allowing slightly different behavior
  # # depending on the controller action. This
  # # should come after the other methods
  
  # def post_params(*args)
  #   params.require(:post).permit(*args)
  # end 

end
