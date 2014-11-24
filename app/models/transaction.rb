class Transaction < ActiveRecord::Base

	belongs_to :init_user, :class_name => "User", :foreign_key => "initiator"
	belongs_to :joke_user, :class_name => "User", :foreign_key => "jokester"

	validates :quantity, presence: true, numericality: { greater_than: 0, less_than: 3}
	validates :comment, presence: true, length: { maximum: 141 }

end
