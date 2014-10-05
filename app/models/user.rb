class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

   has_many :books
   has_many :inspirations, dependent: :destroy
   has_many :comments, dependent: :destroy
   has_many :votes, dependent: :destroy

   has_attached_file :profile_image, :styles => { :medium => "300x300#", :thumb => "100x100#" }, :default_url => "missing.png", :s3_host_name => "s3-us-west-2.amazonaws.com"

   validates_attachment_content_type :profile_image, :content_type => /\Aimage\/.*\Z/
end
