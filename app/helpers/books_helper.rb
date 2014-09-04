module BooksHelper
	def comment_number
		comment_count = []
		comment_count << (Comment.find_by inspiration_id: 1)
		return comment_count.length
	end
end
