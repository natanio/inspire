class Inspiration < ActiveRecord::Base
	belongs_to :user
	belongs_to :book
	has_many :comments

	delegate :title, :link, :to => :book, :prefix => true
end
