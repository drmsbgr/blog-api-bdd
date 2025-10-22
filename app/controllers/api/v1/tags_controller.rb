# app/controllers/api/v1/tags_controller.rb
class Api::V1::TagsController < ApplicationController
  before_action :set_tag, only: [:show, :update, :destroy]

  # GET /api/v1/tags
  def index
    @tags = Tag.all
    render json: @tags
  end

  # GET /api/v1/tags/:id
  def show
    # Bu etikete sahip tüm post'ları gösterelim
    render json: @tag.as_json(include: :posts)
  end

  # POST /api/v1/tags
  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      render json: @tag, status: :created
    else
      render json: @tag.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/tags/:id
  def update
    if @tag.update(tag_params)
      render json: @tag
    else
      render json: @tag.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/tags/:id
  def destroy
    @tag.destroy
    render json: { message: 'Tag deleted successfully' }, status: :ok
  end

  private

  def set_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name)
  end
end