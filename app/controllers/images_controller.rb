class ImagesController < ApplicationController
	before_action :set_image, only: [:destroy]

	def new
		@image = Image.new(listing_id: params[:listing_id])
	end

	def destroy
		@image&.destroy
	end

	private

	def set_image
		@image = Image.find(params[:id])
	end
end