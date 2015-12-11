class BootcampCommentsController < ApplicationController

	def new
		# @comment = BootcampComment.new
	end

	def create
		@bootcamp = Bootcamp.find(params[:bootcamp_id])
		@comment = @bootcamp.bootcamp_comments.create(bootcamp_comment_params)
		redirect_to :back

		# if @comment.save
		# 	redirect_to @bootcamp, notice: 'Comment was successfully created.'
		# else
		# 	render :new
		# end
	end

	def destroy
		@comment = BootcampComment.find(params[:id])
        @comment.destroy
        # redirect_to :back
    end

private

	def bootcamp_comment_params
		params.require(:bootcamp_comment).permit(:body, :bootcamp_id)
	end
end