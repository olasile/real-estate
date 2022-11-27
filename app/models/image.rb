class Image
	include ApplicationRecord

	belongs_to :listing

	mount_uploader :file, PhotoUploader

	validates :file, presence: true
end