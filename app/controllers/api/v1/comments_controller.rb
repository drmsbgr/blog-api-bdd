class Api::V1::CommentsController < Api::ApiController
  # index ve create için URL'den :post_id'yi alıp @post'u bul
  before_action :set_post, only: [:index, :create]

  # update ve destroy için URL'den :id'yi alıp @comment'i bul
  before_action :set_comment, only: [:show, :update, :destroy]

  # GET /api/v1/posts/:post_id/comments
  # Belirli bir posta ait tüm yorumları listeler
  def index
    @comments = @post.comments
    render json: @comments.as_json(include: :user) # Yorum sahibini (user) de göster
  end

  # POST /api/v1/posts/:post_id/comments
  # Belirli bir posta yeni yorum ekler
  def create
    @comment = @post.comments.new(comment_params)

    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # GET /api/v1/comments/:id
  # Tek bir yorumu gösterir (Bunu rotalara eklediysen)
  def show
    render json: @comment.as_json(include: [:user, :post])
  end

  # PATCH/PUT /api/v1/comments/:id
  # Tek bir yorumu günceller
  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/comments/:id
  # Tek bir yorumu siler
  def destroy
    @comment.destroy
    render json: { message: 'Comment deleted successfully' }, status: :ok
    # Veya hiçbir şey dönme: head :no_content
  end

  private

  # Güvenlik için Strong Parameters
  def comment_params
    # :user_id'nin ve :body'nin gelmesine izin ver
    params.require(:comment).permit(:body, :user_id)
  end

  # URL'deki :post_id'den Post'u bulan metot
  def set_post
    @post = Post.find(params[:post_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Post not found' }, status: :not_found
  end

  # URL'deki :id'den Comment'i bulan metot
  def set_comment
    @comment = Comment.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Comment not found' }, status: :not_found
  end
end