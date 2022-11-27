class ContactMailer < ApplicationMailer
	def send_message
		@contact = Contact.find(params[:id])

		mail(to: @contact.listing.agent_email,
				 subject: 'New Contact Message'
		)
	end
end

