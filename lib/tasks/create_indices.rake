desc 'Create indices'
task create_indices: :environment do
	unless Listing.__elasticsearch__.index_exists?
		Listing.__elasticsearch__.create_index!(force: true)
		Listing.import
	end
end
