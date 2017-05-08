App.update_gps = App.cable.subscriptions.create("UpdateGpsChannel", {
  // Called when the subscription is ready for use on the server
  connected: function() {
    return alert('connected')
  },
  // Called when the subscription has been terminated by the server
  disconnected: function() {
    // return alert('disconnected')
  },
  received: function(data) {
    var $target = $('#flight-list')


    var origin1 = {
      lat: parseFloat(data.content.split(',').shift()),
      lng: parseFloat(data.content.split(',').pop())
    };


    var newLatLng = new google.maps.LatLng({
        lat: origin1.lat,
        lng: origin1.lng
      })


    var marker1 = new google.maps.Marker({
              map: map,
              draggable: true,
              position: {lat: origin1.lat, lng: origin1.lng} // this should be last known
            });

    // Called when there's incoming data on the websocket for this channel
    // #eturn alert(data.content)

    // function initMap() {


      var bounds = new google.maps.LatLngBounds;
      var markersArray = [];

      // marker1.setPosition(newLatLng);
      var destinationA = 'Chinatown, Singapore';

      var destinationIcon = 'https://chart.googleapis.com/chart?chst=d_map_pin_letter&chld=D|FF0000|000000';
      var originIcon = 'https://chart.googleapis.com/chart?chst=d_map_pin_letter&chld=O|FFFF00|000000';
      var map = new google.maps.Map(document.getElementById('map'), {
        center: {
          lat: 1.3521,
          lng: 103.8198
        },
        zoom: 10
      });

      var geocoder = new google.maps.Geocoder;

      var service = new google.maps.DistanceMatrixService;

      service.getDistanceMatrix({
        origins: [origin1],
        destinations: [destinationA],
        travelMode: 'DRIVING',
        unitSystem: google.maps.UnitSystem.METRIC,
        avoidHighways: false,
        avoidTolls: false
      }, function(response, status) {
        if (status !== 'OK') {
          alert('Error was: ' + status);
        } else {
          var directionsDisplay = new google.maps.DirectionsRenderer;
          var directionsService = new google.maps.DirectionsService()
          var originList = response.originAddresses;
          var destinationList = response.destinationAddresses;
          var outputDiv = document.getElementById('output');
          outputDiv.innerHTML = '';
          // deleteMarkers(markersArray);

          var showGeocodedAddressOnMap = function(asDestination) {
            var icon = asDestination ? destinationIcon : originIcon;
            return function(results, status) {
              if (status === 'OK') {
                map.fitBounds(bounds.extend(results[0].geometry.location));
                markersArray.push(new google.maps.Marker({   map: map,   position: results[0].geometry.location,   icon: icon }) );

                directionsDisplay.setMap(map)
                directionsService.route({
                  origin: origin1,
                  destination: destinationA,
                  travelMode: 'DRIVING'
                }, function(result, status) {
                  if (status == 'OK') {
                    directionsDisplay.setDirections(result);
                    console.log('direction service')
                  } else {
                    alert('Geocode was not successful due to: ' + status);
                  }
                });

              } else {
                alert('Geocode was not successful due to: ' + status);
              }
            };
          };

          for (var i = 0; i < originList.length; i++) {
            var results = response.rows[i].elements;
            geocoder.geocode({
              'address': originList[i]
            }, showGeocodedAddressOnMap(false));
            for (var j = 0; j < results.length; j++) {
              geocoder.geocode({
                'address': destinationList[j]
              }, showGeocodedAddressOnMap(false));
              outputDiv.innerHTML += originList[i] + ' to ' + destinationList[j] + ': ' + results[j].distance.text + ' in ' + results[j].duration.text + '<br>';
            }
          }
        }
      });
    // }


  }
})
