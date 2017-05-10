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

    var gps = {
      lat: parseFloat(data.content.split(',').shift()),
      lng: parseFloat(data.content.split(',').pop())
    }

    deleteMarkers(markersArray)

    var marker1 = new google.maps.Marker({
      map: window.map,
      draggable: true,
      icon: '/images/icecream1.png',
      position: {
        lat: gps.lat,
        lng: gps.lng
      } // this should be last known
    })

    markersArray.push(marker1)

    function deleteMarkers (markersArray) {
      for (var i = 0; i < markersArray.length; i++) {
        markersArray[i].setMap(null)
      }
      markersArray = []
    }
  }
})  
