# app/controllers/api/v1/posts_controller.rb
class Api::V1::PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]

  # GET /api/v1/posts
  def index
    @posts = Post.all
    # Tüm ilişkileri (user, comments, tags) JSON'da göster
    render json: @posts.as_json(include: [:user, :comments, :tags])
  end

  # GET /api/v1/posts/:id
  def show
    render json: @post.as_json(include: [:user, :comments, :tags])
  end

  # POST /api/v1/posts
  def create
    # 5. modelin (PostTag) çalıştığı yer burası.
    # :tag_ids array olarak gelince, Rails 'has_many :through' sayesinde
    # PostTag tablosuna kayıtları otomatik atar.
    @post = Post.new(post_params)

    if @post.save
      render json: @post, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/posts/:id
  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/posts/:id
  def destroy
    @post.destroy
    render json: { message: 'Post deleted successfully' }, status: :ok
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  # ÖNEMLİ: :tag_ids array'ini [] olarak ekledik.
  def post_params
    params.require(:post).permit(:title, :content, :user_id, tag_ids: [])
  end
end