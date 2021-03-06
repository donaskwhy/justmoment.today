class PostsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    #모든 포스트를 보여주는 뷰

    @posts = Post.all.reverse

  end
  
  def show
    #한개의 포스트를 보여주는 뷰
    @post = Post.find(params[:id])
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    
    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_path, notice: "게시물이 성공적으로 게시되었습니다." }
      else
        format.html { render :new, "에러가 발생했습니다." }
      end
    end
  end
    
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to posts_path, notice: "게시물이 성공적으로 수정되었습니다." }
      else
        format.html { render :new, "에러가 발생했습니다." }
      end
    end
  end
 
 def destroy
   @post = Post.find(params[:id])
   @post.destroy
   redirect_to '/'
 end
 
 def mypage
   
    @posts = Post.all
  end
  

 
 def post_params
   params.require(:post).permit(:title, :content, :image, :game_type)
 end
 
end
