class CommentsController < ApplicationController
	def index
		@comments = Comment.paginate(page: params[:page])
	end

	def create
		@comment = Comment.new(comment_params)
		@entry = Entry.find(@comment.entry_id)
		@comment.save
		respond_to do |format|
	      format.js
	    end
		# if @comment.save
		# 	respond_to do |format|
	 #      format.js
	 #    end
		# 	# redirect_to @entry
		# else
		# 	flash.now[:danger] = "error"
		# 	redirect_to @entry
		# end
	end

	private
   def comment_params
        params.require(:comment).permit(:user_id, :entry_id, :content)
   end
end
