class User < ActiveRecord::Base

	has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
	# Validate content type
	validates_attachment_content_type :avatar, :content_type => /\Aimage/
	  	
	has_many :init_transactions, :class_name => "Transaction", :foreign_key => "initiator", :dependent => :destroy
	has_many :joke_transactions, :class_name => "Transaction", :foreign_key => "jokester", :dependent => :destroy

	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

	# before_action :authenticate_user!
	validates :username, presence: true, uniqueness: true

	# validates :first_name, presence: true
	# validates :last_name, presence: true

end
