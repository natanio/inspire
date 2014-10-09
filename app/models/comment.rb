class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :inspiration

	delegate :book, :to => :inspiration, :prefix => true

	validates :content, presence: true
 
	def to_edit_path
	  Rails.application.routes.url_helpers.edit_book_inspiration_comment_path inspiration_book, inspiration, self
	end
 
	def to_path
	  Rails.application.routes.url_helpers.book_inspiration_comment_path inspiration_book, inspiration, self
	end
 
	def serializable_hash(*args)
	  super.merge 'path' => to_path, 'edit_path' => to_edit_path
	end
end
