class FavoritesController < ApplicationController
	before_action :set_inspiration

	def create
		if Favorite.create(favorited: @inspiration, user: current_user)		
			respond_to do |format|
		      if @favorite.save
		        format.html { redirect_to @inspiration.book, notice: 'You have favorited a new inspiration.' }
		        format.js
		      else
		        redirect_to @inspiration.book, alert: "Something went wrong..."
		      end
		    end
	end

	def destroy
		Favorite.where(favorited_id: @inspiration.id, user_id: current_user.id).first.destroy
		redirect_to @inspiration.book, notice: "You'v unfavorited that inspiration."
	end

	private

	def set_inspiration
		@inspiration = Inspiration.find(params[:inspiration_id] || params[:id])
	end
end