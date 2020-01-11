$(function () {

	let map;
	let service;
	let button = document.getElementById('getCurrentPosition');

	button.onclick = function(){
		window.navigator.geolocation.getCurrentPosition(
			function(position){
				var lat = position.coords.latitude;
				var lng = position.coords.longitude;

				map = new google.maps.Map(document.getElementById('map'),{
					center: {lat: lat, lng: lng},
					zoom: 15
				});

				var request = {
					location: new google.maps.LatLng(lat, lng),
					radius: 1000,
					query: 'テニスコート'
				};

				service = new google.maps.places.PlacesService(map);
				service.textSearch(request, Result_Places);
			});
	}

	function Result_Places(results, status){
		if(status==google.maps.places.PlacesServiceStatus.OK){
			for(var i=0; i<results.length; i++){
				var place = results[i];

				// 施設名・施設の住所を表示する
				$('#name-' + i).html(place.name);
				var address = (place.formatted_address).split('、')[1];
				$('#address-' + i).html(address);


				createMarker({
					text: place.name,
					position: place.geometry.location
				});
			}
		}
	}

	function createMarker(options){
		options.map = map;
		var marker = new google.maps.Marker(options);
		var infoWnd = new google.maps.InfoWindow();
		infoWnd.setContent(options.text);
		google.maps.event.addListener(marker, 'click', function(){
			infoWnd.open(map, marker);
		});
		return marker;
	}


});