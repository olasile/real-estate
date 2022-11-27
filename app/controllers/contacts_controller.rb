class ContactsController < ApplicationController
	before_action :set_listing, only: [:create]

	def create
		@contact = Contact.new(permitted_params)
		@contact.listing = @listing

		if @contact.save
			flash.now[:success] = 'Message successfully sent'
		else
			flash.now[:error] = error_messages(@contact)
		end
	end

	private

	def permitted_params
		params.require(:contact).permit(:message)
	end

	def set_listing
		@listing = Listing.find(params[:listing_id])
		redirect_to(listings_path, flash: { error: 'Invalid Listing' }) unless @listing.present?
	end
end