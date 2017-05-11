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

    // splits concatenated gps data into .lat lng)
    var gps = {
      lat: parseFloat(data.content.split(',').shift()),
      lng: parseFloat(data.content.split(',').pop())
    }

    // deletes the previous GPS markers upon broadcast by GPS
    deleteMarkers(markersArray)

    // creates a new GPS marker
    var newGpsMarker = new google.maps.Marker({
      map: window.map, // teehee
      draggable: true,
      icon: '/images/icecream1.png', // customize your markers here!
      position: {
        lat: gps.lat,
        lng: gps.lng
      }
    })

    // pushes the GPS marker into an array -- in case we have more than one marker
    markersArray.push(newGpsMarker)

    // Function to delete all markers
    function deleteMarkers (markersArray) {
      for (var i = 0; i < markersArray.length; i++) {
        markersArray[i].setMap(null)
      }
      markersArray = []
    }
  }
})
