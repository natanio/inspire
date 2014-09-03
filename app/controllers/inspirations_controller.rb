class InspirationsController < ApplicationController
  before_action :set_inspiration, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show]
  before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /inspirations
  # GET /inspirations.json
  def index
    @inspirations = Inspiration.all
  end

  # GET /inspirations/1
  # GET /inspirations/1.json
  def show
  end

  # GET /inspirations/new
  def new
    @inspiration = Inspiration.new
  end

  # GET /inspirations/1/edit
  def edit
  end

  # POST /inspirations
  # POST /inspirations.json
  def create
    @inspiration = Inspiration.new(inspiration_params)
    @inspiration.user_id = current_user.id

    respond_to do |format|
      if @inspiration.save
        format.html { redirect_to @inspiration, notice: 'Inspiration was successfully created.' }
        format.json { render action: 'show', status: :created, location: @inspiration }
      else
        format.html { render action: 'new' }
        format.json { render json: @inspiration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inspirations/1
  # PATCH/PUT /inspirations/1.json
  def update
    respond_to do |format|
      if @inspiration.update(inspiration_params)
        format.html { redirect_to @inspiration, notice: 'Inspiration was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @inspiration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inspirations/1
  # DELETE /inspirations/1.json
  def destroy
    @inspiration.destroy
    respond_to do |format|
      format.html { redirect_to inspirations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inspiration
      @inspiration = Inspiration.find(params[:id])
    end

    def correct_user
      @inspiration = current_user.inspirations.find_by(id: params[:id])
      redirect_to books_path, alert: "Sorry. This isn't yours." if @book.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inspiration_params
      params.require(:inspiration).permit(:quote, :page_number, :likes)
    end
end
