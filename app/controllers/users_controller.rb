class UsersController < ApplicationController

	def show
    @user = User.find(params[:id])
    @user_favorites = @user.favorite_inspirations
    @book = Book.find_by(:id, @inspiration)

    respond_to do |format|
        format.html # show.html.erb
        format.xml { render :xml => @user }
    end
  end

  private

end