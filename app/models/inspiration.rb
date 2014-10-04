class Inspiration < ActiveRecord::Base
	belongs_to :user
	belongs_to :book
	has_many :comments
	has_many :votes, dependent: :destroy

	delegate :title, :link, :to => :book, :prefix => true

	def new_comment_path
	  Rails.application.routes.url_helpers.new_book_inspiration_comment_path(book, self)
	end
 
	def serializable_hash(*args)
	  super.merge 'new_comment_path' => new_comment_path
	end
end
