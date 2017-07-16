class CommentsController < ApplicationController

  def show
    @comment = Comment.find(params[:id])
    authorize(@comment)
    render json: { data: @comment.serialized }
  end

  def create
    comment = Comment.new( comments_params.merge(user_id: current_user.id) )
    authorize(comment)
    status = comment.save ? 200 : 422
    render json: {data: comment.serialized, errors: comment.errors}, status: status
  end

  def update
    comment = Comment.find(params[:id])
    authorize(comment)
    if comment.update_attributes(comments_params)
      render json: {data: comment.serialized }, status: 200
    else
      render json: {data: comment.serialized, errors: comment.errors}, status: 422
    end    
  end

  def destroy
    comment = Comment.find(params[:id])
    authorize(comment)
    if comment.destroy
      render json: {data: comment.serialized }, status: 200
    else
      render json: {data: comment.serialized, errors: comment.errors, flash: { type: "error", message: I18n.t("flash.cant_destroy_comment") }}, status: 422
    end
  end

  private

    def comments_params
      params[:comment].permit(:commentable_id, :commentable_type, :description, :date)
    end

end