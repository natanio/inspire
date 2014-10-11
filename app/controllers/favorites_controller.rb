class FavoritesController < ApplicationController
	before_action :set_inspiration

	def create
		Favorite.create(favorited: @inspiration, user: current_user)
		render :create
	end

	def destroy
		Favorite.where(favorited_id: @inspiration.id, user_id: current_user.id).first.destroy
		render :create
	end

	private

	def set_inspiration
		@inspiration = Inspiration.find(params[:inspiration_id] || params[:id])
	end
end