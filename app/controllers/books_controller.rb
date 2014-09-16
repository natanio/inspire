require "html_truncator"

class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show, :search]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def search
    if params[:search].present?
      @books = Book.search(params[:search])
    else
      @books = Book.all
    end
  end

  # GET /books
  # GET /books.json
  def index
    @books = Book.all
  end

  # GET /books/1
  # GET /books/1.json
  def show
    @inspirations = Inspiration.where(book_id: @book.id)
  end

  # GET /books/new
  def new
    @book = current_user.books.build
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = current_user.books.build(book_params)
    @book.preview = HTML_Truncator.truncate(@book.description, 20)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render action: 'show', status: :created, location: @book }
      else
        format.html { render action: 'new' }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    @book.preview = HTML_Truncator.truncate(@book.description, 20)

    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    def correct_user
      @book = current_user.books.find_by(id: params[:id])
      redirect_to books_path, alert: "Not authorized to edit this book" if @book.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :link, :genre, :image, :description, :date_publish, :preview, :user_id)
    end
end
