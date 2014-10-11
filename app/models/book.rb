class Book < ActiveRecord::Base
	belongs_to :user
	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
	has_many :inspirations
	has_many :comments, through: :inspirations
	has_many :favorites, through: :inspirations

	searchkick

end
