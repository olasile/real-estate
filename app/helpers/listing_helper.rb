module ListingHelper
	def listing_price(listing)
		listing.price / 100.00 if listing.price.present?
	end
end