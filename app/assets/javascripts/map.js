$(function () {

	let map;
	let origin;
	let places;
	let markers = new Array();
	let button = document.getElementById('getCurrentPosition');

	button.onclick = function(){
		window.navigator.geolocation.getCurrentPosition( function(position){
			var lat = position.coords.latitude;
			var lng = position.coords.longitude;
			origin = new google.maps.LatLng(lat,lng);

			map = new google.maps.Map(document.getElementById('map'),{
				center: origin,
				zoom: 18,
				mapTypeId: google.maps.MapTypeId.ROADMAP
			});

			var originMarker = new google.maps.Marker({
				map: map,
				position: origin,
				animation: google.maps.Animation.DROP,
				title: '現在地',
				icon: {
					url: '/assets/marker.png'
				}
			});

			var request = {
				location: new google.maps.LatLng(lat, lng),
				radius: 1000,
				query: 'テニスコート'
			};

			var service = new google.maps.places.PlacesService(map);
			service.textSearch(request, function(results, status) {
				if (status == google.maps.places.PlacesServiceStatus.OK) {
					var bounds = new google.maps.LatLngBounds();
					for (var i=0; i<results.length; i++){
						var place = results[i];
						createMarker({
							text: place.name,
							position: place.geometry.location
						});
						bounds.extend(place.geometry.location);
					};
					map.fitBounds(bounds);
					places = results;
					calcDistanceMatrix(places);
				} else {
					alert('検索失敗(' + status + ')');
				}
			});
		});
	};

	function createMarker(options) {
		options.map = map;
		var marker = new google.maps.Marker(options);
		var infoWindow = new google.maps.InfoWindow();
		markers.push(marker);
		infoWindow.setContent(options.text);
		google.maps.event.addListener(marker, 'click', function(){
			infoWindow.open(map, this);
		});
		return marker;
	}

	function clearPlacesMarker() {
		for (var i=0; i<markers.length; i++) {
			markers[i].setMap(null);
		}
		markers = new Array();
	};

	function calcDistanceMatrix(places) {
		var destinations = new Array();
		for (var i=0; i<places.length; i++) {
			destinations.push(places[i].geometry.location);
		}

		var distanceMatrixService = new google.maps.DistanceMatrixService();

		distanceMatrixService.getDistanceMatrix({
			origins: [origin],
			destinations: destinations,
			travelMode: google.maps.DirectionsTravelMode.WALKING,
			avoidHighways: true,
			avoidTolls: true,
			avoidFerries: true
		}, function(results, status) {
			if (status == google.maps.DistanceMatrixStatus.OK) {
				var sortResults = new Array();

				var origins = results.originAddresses;
				var destinations = results.destinationAddresses;

				for (var i=0; i<origins.length; i++) {
					var result = results.rows[i].elements;

					for (var j=0; j< result.length; j++) {
						var from = origins[i];
						var to = destinations[j];
						var duration = result[j].duration.value;
						var distance = result[j].distance.value;
						sortResults.push([from, to, duration, distance, result[j], j]);
					}
				}
				sortResults.sort(function(a,b) {
					return a[2] - b[2];
				});

				var html = new Array();
				for (var i=0; i<sortResults.length; i++) {
					var placeNo = sortResults[i][5];
					html.push('<tr data-index="' + placeNo + '">');
					html.push('<td>' + places[placeNo].name + '</td>');
					html.push('<td>' + sortResults[i][4].duration.text + '</td>');
					html.push('<td>' + sortResults[i][4].distance.text + '</td>');
					html.push('</tr>');
				}
				$('#result-body').html(html.join(''));

				$('#result-body tr').on('click', function() {
					var i = this.dataset.index;
					var place = places[i];
					calcRoute(place.geometry.location);
					google.maps.event.trigger(markers[i], 'click')
				});
			} else {
				alert('失敗(' + status + ')');
			}
		});
	};

	function calcRoute(end) {
		var directionsRenderer = new google.maps.DirectionsRenderer();
		var directionsService = new google.maps.DirectionsService();

		var clearRoute = function() {
			directionsRenderer.setDirections(null);
		}

		directionsRenderer.setMap(map);
		directionsService.route({
			origin: origin,
			destination: end,
			travelMode: google.maps.DirectionsTravelMode.WALKING,
		}, function(results, status) {
			if (status == google.maps.DirectionsStatus.OK) {
				directionsRenderer.setDirections(results);
			} else {
				alert('経路表示失敗(' + status + ')');
			}
		});
	};
});