class Listing
	include ApplicationRecord
	include Elasticsearch::Model
	include Elasticsearch::Model::Callbacks

	field :description, type: String
	field :price, type: BigDecimal
	field :beds, type: Integer
	field :baths, type: Integer
	field :agent_name, type: String
	field :agent_email, type: String

	has_many :images, dependent: :destroy
	has_many :contacts, dependent: :destroy

	accepts_nested_attributes_for :images

	validates :description, :price, :images, :agent_name, :agent_email, presence: true

	index_name "listings-#{Rails.env}"

	settings do
		mappings dynamic: false do
			indexes :beds, type: :integer
			indexes :baths, type: :integer
		end
	end

	def self.search(query)
		puts "query: #{query}"
		__elasticsearch__.search(
				{
						query:
								{
										range: {
												beds: {
														gte: query[:beds_min],
														lte: query[:beds_max],
														boost: 2.0
												}
										},
										range: {
												baths: {
														gte: query[:baths_min],
														lte: query[:baths_max],
														boost: 2.0
												}
										}
								}
				}
		)
	end

	def as_indexed_json(options = nil)
		self.as_json( only: [ :beds, :baths ] )
	end
end
