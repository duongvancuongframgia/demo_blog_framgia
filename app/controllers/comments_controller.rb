class CommentsController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy, :edit, :update]
  before_action :correct_user, only: [:destroy, :eidt, :update]
	def index
		@comments = Comment.paginate(page: params[:page])
	end

	def create
		@comment = Comment.new(comment_params)
		@entry = Entry.find(@comment.entry_id)
		# micropost = Micropost.find(params[:micropost_id])
    # @comment = @micropost.comments.build(comment_params)
    @comment.user_id = current_user.id
		@comment.save
	  respond_to do |format|
      format.html { redirect_to request.referrer }
      format.js
    end
	end

	def edit
		@comment = Comment.find(params[:id])
		respond_to do |format|
        format.html {redirect_to request.referrer}
        format.js
    end
	end

	def update
		@comment = Comment.find(params[:id])
		if @comment.update_attributes(comment_params)
			respond_to do |format|
        format.html {redirect_to request.referrer}
        format.js
    	end
    else 
    	render 'edit'
		end
	end

	def destroy
		@entry = Entry.find(@comment.entry_id)
    @comment.destroy
    respond_to do |format|
        format.html { redirect_to request.referrer }
        format.js
    end
	end

	private
   def comment_params
        params.require(:comment).permit(:entry_id, :content)
   end

   def correct_user
      @comment = Comment.find_by(id: params[:id])
      redirect_to root_url if @comment.nil?
      redirect_to root_url unless (current_user?(@comment.user) || current_user?(@comment.entries.user))
    end
end
