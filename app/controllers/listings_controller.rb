class ListingsController < ApplicationController
	before_action :set_listing, only: [:show, :edit, :update]
  before_action :perform_search, only: [:index, :search]

  def index
  end

	def search
  end

  def new
    @listing = Listing.new
  end

	def show
  end

	def edit
  end

  def create
    @listing = Listing.new(permitted_params)

    if @listing.save
      redirect_to listings_path, flash: { success: 'Listing successfully created.' }
    else
      flash.now[:error] = error_messages(@listing)
      render :new
    end
  end

	def update
    if @listing.update_attributes(permitted_params)
      redirect_to edit_listing_path(@listing.id), flash: { success: 'Listing successfully updated.' }
    else
      flash.now[:error] = error_messages(@listing)
      render :edit
    end
  end


  private

	def perform_search
    page = params[:page] || 1
    per = params[:per_page] || 20
    params[:query] ||= {}

    params[:query].reject! { |_, v| v.blank? }

    results = Listing.search(params[:query])
    @listings = results.page(page).per(per || results.count)
  end

	def set_listing
    @listing = Listing.find(params[:id])
  end

  def permitted_params
    params.require(:listing).permit(:price, :description, :beds, :baths, :agent_name, :agent_email, images_attributes: [:id, :file])
  end
end