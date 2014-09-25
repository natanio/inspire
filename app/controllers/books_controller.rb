require "html_truncator"
require 'amazon/aws/search'

class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show, :search]
  before_action :correct_user, only: [:edit, :update, :destroy]

  #include amazon helpers
  include Amazon::AWS
  include Amazon::AWS::Search

  def search
    if params[:search].present?
      @books = Book.search(params[:search], fields: [:title])

        is = ItemSearch.new( 'Books', { 'Title' => params[:search],
                                        'MerchantId' => 'Amazon' })

        # 'Large' required for images 
        # Could also be 'Small'' for just title & product group
        rg = ResponseGroup.new(:Large)


        # Perform the Search
        req = Request.new('accesskey', 'inspirati0caf-20', 'us', false)
        req.config['secret_key_id'] = 'secretkey'

        resp = req.search( is, rg )

        @results = []
        resp["item_search_response"][0].items[0].item.each do |i|
        # Grab the attributes we want
          title = i.item_attributes.title[0].to_s[0,60]
          group = i.item_attributes.product_group.to_s
          image = amazon_image_set(i.image_sets[0].image_set)
          pub_date = i.item_attributes.publication_date.to_s
          genre = i.item_attributes.genre
          isbn = i.item_attributes.isbn.to_s
          url = i.detail_page_url

          # Add to results array
          @results << { :title => title, :group => group, :image => image, :publication_date => pub_date, :genre => genre, :isbn => isbn, :detail_page_url => url }
        end

        # Return results 0-100 as JSON
        #render :json => results[0..100]

        # If no results, Amazon::AWS throws an error, so we can rescue
        # TODO There's definitely a better way to handle this
        # rescue 
        # render :json => ["None"]
        # end

    else
      flash[:alert] = "Be sure to enter a keyword in your search."
      redirect_to root_path
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

  def load_from_amazon
    isbn = params[:isbn]

    is = ItemLookup.new( 'ISBN', { 'ItemId' => isbn, 'SearchIndex' => 'Books'})

        # 'Large' required for images 
        # Could also be 'Small'' for just title & product group
        rg = ResponseGroup.new(:Large,:ItemAttributes)


        # Perform the Search
        req = Request.new('accesskey', 'inspirati0caf-20', 'us', false)
        req.config['secret_key_id'] = 'secretkey'

        resp = req.search( is, rg )

        @results = []
        amazon_book = resp["item_lookup_response"][0].items[0].item.first
        # Grab the attributes we want
        title = amazon_book.item_attributes.title[0].to_s[0,60]
        group = amazon_book.item_attributes.product_group.to_s
        image = amazon_image_set(amazon_book.image_sets[0].image_set)
        pub_date = amazon_book.item_attributes.publication_date.to_s
        genre = amazon_book.item_attributes.genre
        isbn = amazon_book.item_attributes.isbn.to_s
        url = amazon_book.detail_page_url

          book = Book.find_or_create_by(isbn: isbn) do |book|
            book.title = title
            book.genre = genre
            book.date_publish = pub_date
            book.aws_image_url = image
            book.url = url

          book.save!
          end
          redirect_to book, notice: 'Book was successfully added.'
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

    # Helper function, only argument is an image_set
    # Returns the thumbnail_image url or ""
    # Instead of thumbnail_image, could be small_image, large_image
    def amazon_image_set(set)
      set[0].large_image.url.to_s
      rescue
       ""
    end
end
