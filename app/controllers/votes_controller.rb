class VotesController < ApplicationController
	before_action :setup

	def up_vote
		update_vote(1)
		render :votes
	end

	def down_vote
		update_vote(-1)
		render :votes
	end

	private

	def setup
		# Get the parent objects
		@book = Book.find(params[:book_id])
		@inspiration = @book.inspirations.find(params[:inspiration_id])

		# Look for existing vote so we don't double vote for user
		@vote = @inspiration.votes.where(user_id: current_user.id).first
	end

	def update_vote(new_value)
		if @vote #if it exists, update it
			@vote.update_attribute(:value, new_value)
		else
			@vote = current_user.votes.create(value: new_value, inspiration: @inspiration)
		end
	end
end