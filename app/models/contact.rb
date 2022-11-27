class Contact
	include ApplicationRecord

	belongs_to :listing

	field :message, type: String

	validates :message, presence: true

	after_create :send_message

	def send_message
		ContactMailer.with(id: id.to_s).send_message.deliver_now
	end
end