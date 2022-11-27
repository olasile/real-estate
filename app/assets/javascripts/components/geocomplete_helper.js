GeocompleteHelper = {
	geocode_address: function (id, name, opts={}) {

		$('#' + id).geocomplete(opts)
			.bind("geocode:result", function (event, result) {
				// console.log(result.address_components)

				var postCode = GeocompleteHelper.extractAttributeFromAdress(result.address_components, "postal_code");
				var street = GeocompleteHelper.extractAttributeFromAdress(result.address_components, "route");
				var street_number = GeocompleteHelper.extractAttributeFromAdress(result.address_components, "street_number");
				var town = GeocompleteHelper.extractAttributeFromAdress(result.address_components, "locality") || GeocompleteHelper.extractAttributeFromAdress(result.address_components, "sublocality");
				var country = GeocompleteHelper.extractAttributeFromAdress(result.address_components, "country", true);
				var city_state = GeocompleteHelper.extractAttributeFromAdress(result.address_components, "administrative_area_level_1", true);
				var latitude = result.geometry.location.lat();
				var longitude = result.geometry.location.lng();

				$('#' + name + '_postal_code').val(postCode);
				$('#' + name + '_address1').val(street_number + ' ' + street);
				$('#' + name + '_city').val(town);
				$('#' + name + '_state_province').val(city_state);
				$('#' + name + '_country').val(country);
				$('#' + name + '_latitude').val(latitude);
				$('#' + name + '_longitude').val(longitude);
			})
			.bind("geocode:error", function (event, status) {
				console.log("Error: " + status);
			})
			.bind("geocode:multiple", function (event, results) {
				console.log("Multiple: " + results.length + " results found");
			});
	},
	extractAttributeFromAdress: function (components, type, short_name) {
		for (var i = 0; i < components.length; i++)
			for (var j = 0; j < components[i].types.length; j++)
				if (components[i].types[j] === type) {
					if (short_name) {
						return components[i].short_name;
					} else {
						return components[i].long_name;
					}
				}
		return "";
	}
};
