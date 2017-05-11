App.update_gps = App.cable.subscriptions.create('UpdateGpsChannel', {
  // Called when the subscription is ready for use on the server
  connected: function () {
    // return alert('connected')
  },
  // Called when the subscription has been terminated by the server
  disconnected: function () {
    // return alert('disconnected')
  },
  received: function (data) {
    var $heading = $('#heading') // for troubleshooting because console.log doesnt work
    var $output = $('#output')

    // this gateway blocks any GPS data that is unknown
    if (parseFloat(data.content.split(',').shift()) === 0) {
      $heading.text('Skipped')
      return
    }

    // splits concatenated gps data into .lat lng)
    var gps = {
      lat: parseFloat(data.content.split(',').shift()),
      lng: parseFloat(data.content.split(',').pop())
    }

    // deletes the previous GPS markers upon broadcast by GPS
    deleteMarkers(markersArray)

    // creates a new GPS marker
    var newGpsMarker = new google.maps.Marker({
      map: window.mappymap, // teehee
      draggable: true,
      icon: '/images/icecream1.png', // customize your markers here!
      position: {
        lat: gps.lat,
        lng: gps.lng
      }
    })

    // pushes the GPS marker into an array -- in case we have more than one marker
    markersArray.push(newGpsMarker)

    calculateNewDist(gps, window.gpsDestination)

    function calculateNewDist (gps_A, gps_B) {
      var geocoder = new google.maps.Geocoder()
      var service = new google.maps.DistanceMatrixService()
      service.getDistanceMatrix({
        origins: [gps_A],
        destinations: [gps_B],
        travelMode: 'DRIVING',
        unitSystem: google.maps.UnitSystem.METRIC,
        avoidHighways: false,
        avoidTolls: false
      }, function (response, status) {
        if (status !== 'OK') {
          alert('Error was: ' + status)
        } else {
          var directionsDisplay = new google.maps.DirectionsRenderer()
          var directionsService = new google.maps.DirectionsService()
          var originList = response.originAddresses
          var destinationList = response.destinationAddresses

          var showGeocodedAddressOnMap = function (asDestination) {
            return function (results, status) {
              if (status === 'OK') {
                window.mappymap.fitBounds(bounds.extend(results[0].geometry.location))
                directionsDisplay.setMap(window.mappymap)
                directionsService.route({
                  origin: gps_A,
                  destination: gps_B,
                  travelMode: 'DRIVING'
                }, function (result, status) {
                  if (status == 'OK') {
                    directionsDisplay.setDirections(result)
                    console.log('direction service')
                  } else {
                                  // alert('Geocode was not successful due to: ' + status);
                  }
                })
              } else {
                          // alert('Geocode was not successful due to: ' + status);
              }
            }
          }
          for (var i = 0; i < originList.length; i++) {
            var results = response.rows[i].elements
            for (var j = 0; j < results.length; j++) {
              geocoder.geocode({
                'address': destinationList[j]
              }, showGeocodedAddressOnMap(false))
              if (results[j].distance.value < 10) {
                $output.text('Your ice cream has arrived')
                $output.css({'background-color': '#82B588', 'font-size': '36px'})
              } else {
                $output.text('Your ice cream is ' + results[j].distance.text + ' away and arriving in ' + results[j].duration.text)
              }
            }
          }
        }
      })
    }
    // Function to delete all markers
    function deleteMarkers (markersArray) {
      for (var i = 0; i < markersArray.length; i++) {
        markersArray[i].setMap(null)
      }
      markersArray = []
    }
  }
})
