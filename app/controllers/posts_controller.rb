# app/controllers/posts_controller.rb
class PostsController < ApplicationController
  def show
    # @post'u bul ve view'a gönder
    @post = Post.find(params[:id])
  end
end