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
    // var $target = $('#flight-list')

    // var dummy = {
    //   lat: 1.3200,
    //   lng: 103.8439
    // }

    var gps = {
      lat: parseFloat(data.content.split(',').shift()),
      lng: parseFloat(data.content.split(',').pop())
    }

    // var newLatLng = new google.maps.LatLng({
    //   lat: gps.lat,
    //   lng: gps.lng
    // })

    // var map = new google.maps.Map(document.getElementById('map'), {
    //   center: {
    //     lat: gps.lat,
    //     lng: gps.lng
    //   },
    //   zoom: 13
    // })

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
//   }
// })
