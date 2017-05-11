# Ice Scream! a.k.a The Ice-Craem Man by JAKS

![Ice-Cream Truck](https://s-media-cache-ak0.pinimg.com/originals/f9/d0/d4/f9d0d41c3e65ca986b1e5af0264bc357.gif)

### In memories of the all Singapore's Ice-Cream Uncles

![Ice-Cream Uncle](http://goodyfeed.com/wp-content/uploads/2016/07/Uncle-Sun-Icecream-Vendor.png)

### WDI-JAKS MEETS UX- Tom Allan Elky Wendy

![UX TEAM](/app/assets/images/ux1.jpeg)
![UX TEAM](/app/assets/images/ux2.jpeg)

[Lick Here](https://jaksicecream.herokuapp.com/)

***
### Development

* Devise
* Cloudinary
* MQTT
* ActiveJobs
* Action Cables
* Google Maps Web Services API
  * Geokit
  * Geolocation
  * Distance Matrix
  * Google maps direction
  * Google maps Javascript API geometry library
* Stripes Payment API
* Bulma

* Arduino, C++, JQuery, Ruby On Rails, Postgresql, Heroku

***
### Workings

#### ERD
![ERD](https://github.com/DarkArtistry/airporter/blob/master/icecream%20man.png?raw=true)

#### User flow by UX-Team

![User Flow](/app/assets/images/ux.png)

Start Project, first with connecting to the database and install express then login page & feature exploration!

#### workablity

[![IMAGE ALT TEXT HERE](/app/assets/images/device.jpeg)](https://www.youtube.com/watch?v=7oUnfpX7QBM&feature=youtu.be)
***
### Hiccups & Techniques

#### 1. Database Structure

![User Flow](/app/assets/images/database1.png)

```
class Orderitem < ApplicationRecord

  belongs_to :user
  belongs_to :supplier
  belongs_to :flavour
  belongs_to :container
  belongs_to :invoice, optional: true

end
```

#### 2. Cloudinary

```
<%= form_for :picture ,url:add_image_path do |f| %>
<%= f.file_field :public_id %>
<%= f.submit 'Add image', class: 'button is-primary' %>
<% end %>
```
Post request to add image

```
if params[:picture][:public_id]
  uploaded_file = params[:picture][:public_id].path
  cloudnary_file = Cloudinary::Uploader.upload(uploaded_file)
  @picture.supplier_id=current_supplier.id
  @picture.public_id = cloudnary_file['public_id']
def picture_params
params.require(:picture).permit(:public_id)
end
```

Cloudinary by default assign a public id to files that are being uploaded
public id is stored in public_id field
used for reference for cl_image_tag method which reference to public_id to display the url of the cloudinary file

```
<% current_supplier.pictures.each do |picture| %>
<%= cl_image_tag(picture.public_id, :width => 200, :height => 200) %>
<% end %>
```

#### 3. Goooogle!

For finding suppliers by name, address, or neighbourhood. If user enters current location, run the current location search by radius method

```
def index

    field = params[:field]? params[:field].downcase : ''
    @title = field.titleize
   if field.to_s == 'current location'
    redirect_to action: :location_search
     else
   @suppliers = Supplier.where("LOWER(name) LIKE ? OR LOWER(address) LIKE ? OR LOWER(neighbourhood) LIKE ?", "%#{field}%", "%#{field}%", "%#{field}%")
 end
  end
```

```
def search
  field = params[:field]? params[:field].downcase : ''
  @suppliers = Supplier.where("LOWER(name) LIKE ? OR LOWER(location) = ?", "%#{field}%", "%#{field}%")
end
```
Finds current user location and gets the lat and lng for it. Then, it gets all the suppliers lat and lng, and computes the distance between them. If the distance is <5km, create the restaurant div to reflect the restaurant upon search by location.

```
if (navigator.geolocation) {
          navigator.geolocation.getCurrentPosition(function(position) {
            var pos = {
              lat: position.coords.latitude,
              lng: position.coords.longitude
            };

            gon.suppliers.forEach(function(supplier){

              var distance = google.maps.geometry.spherical.computeDistanceBetween(new google.maps.LatLng({lat: pos.lat, lng: pos.lng}), new google.maps.LatLng({lat: supplier.lat, lng: supplier.lng})) / 1000
              if (distance <5){

                var $target = $('#searched')
                  // creation of the div
                  var $new_restaurant_link = $('<a href="/suppliers/"'+ supplier.id +' class="column is-half is multiline">')
                  var $new_restaurant_div = $('<div id='+ supplier.id +'>')
                  var $new_restaurant_p = $('<p class="notification is-info">')
                  var $new_restaurant_p_code = $('<code class="html">'+  supplier.name +'</code>')

                  $new_restaurant_p_code.text(supplier.name)
                  $new_restaurant_p.append($new_restaurant_p_code)
                  $new_restaurant_div.append($new_restaurant_p)
                  $new_restaurant_link.append($new_restaurant_div)
                  $target.append($new_restaurant_link)
              }
            })
          });
        }
      }
```

```
def after_sign_up_path_for(resource)
  loc=MultiGeocoder.geocode(filter_params[:address])
    if loc.success
      updated_supplier = Supplier.last
      updated_supplier.lat = loc.lat.to_f
      updated_supplier.lng = loc.lng.to_f
      updated_supplier.address = loc.full_address
      updated_supplier.neighbourhood = loc.neighborhood
      updated_supplier.save
    end
  suppliers_path(resource)  
end

private
def filter_params
  params.require(:supplier).permit(:address)

end
```

Redirection of routes from the devise controller. Typically, devise automatically creates new users/suppliers and reroutes to the root page upon signup. We redirected the suppliers upon signup such that it will run the code above to geocode the supplier address first, and then redirect back to the root page. As a result, we store the lat, lng, neighbourhood, and edit the address input to a more standardize address by Geokit.

#### 4. MQTT

![MQTT](/app/assets/images/MQTT.png)

I used CGI (Common Gateway Interface) to access ENV variables and URI (Universal Resource Identifiers) to parse the common url into host, post, user and password into key-value pairs. Format:  

```
db:engine:[//[user[:password]@][host][:port]/][dbname][?params][#fragment]
```

Nifty trick, read more about it here: http://search.cpan.org/~dwheeler/URI-db-0.17/lib/URI/db.pm

```
class MqttJob < ApplicationJob
  queue_as :urgent

  def perform(*_args)
    # sets up the recurring job

    # Create a hash with the connection parameters from the URL or collect to the local mqtt client server (on heroku)
    uri = URI.parse ENV['CLOUDMQTT_URL'] || 'mqtt://localhost:1883'

    conn_opts = {
      remote_host: uri.host,
      remote_port: uri.port,
      username: uri.user,
      password: uri.password
    }
```
For the IoT client-server, I really needed a daemon (a background task running in parallel with the app to constantly listen for messages, as well as poll requests to the device for GPS coordiantes and other actions. Rails is a not an event-driven coding environment but it has something really awesome called threads. I initiated one above and ran the Active Job in the background! This allows the server (or any long-running/recurrent jobs you might need) to run in the background while you continue to navigate around the website. Very neat!

Upon connecting to the server, and receiving a message -- say a set of GPS coordinates under the topic “current_GPS” (think ‘channel’ for IoT brokers/off-line webservers), the active job will broadcast the message via action cable to the ‘update_gps_channel’ -- which triggers the javascript to update the GPS coordinates on the views



```
puts conn_opts

   # Subscribe example
   # Threads are the most awesome thing ever
   Thread.new do
     MQTT::Client.connect(conn_opts) do |c|
       # The block will be called when you messages arrive to the topic
       c.get('current_GPS') do |topic, message|
         puts "#{topic}: #{message}"
         # broadcasts the message upon receiving it via action cable
         ActionCable.server.broadcast 'update_gps_channel',
                                      content: message,
                                      author: 'seth'
         # username: current_user
       end
     end
   end

```
 Publish example
 Threads are the most awesome thing ever

 I tried automatically enqueuing the class to run again -- using self.class.perform_later(wait: 5.seconds) but that didn’t work so well. So I used a loop with a sleep interval and another thread to poll the server. Magical.
```
Thread.new do
  MQTT::Client.connect(conn_opts) do |c|
    # publish a message to the topic
    loop do
      # polling the device for GPS coordinates please
      c.publish('action', '1', retain = false)
      # set the time frequency here
      sleep 5
    end
  end
end
end
end
```
This section splits the GPS message string “1.30756,103.83139’ into float latitudes and longitudes

```
received: function (data) {

  // splits concatenated gps data into .lat lng)
  var gps = {
    lat: parseFloat(data.content.split(',').shift()),
    lng: parseFloat(data.content.split(',').pop())
  }
```
I started off by deleting the previous markers, and creating a new marker in the map passed on from views through window (for the lack of a better way) and customized the marker to our logo. This displays the marker on some point on the map to indicate where the delivery man currently is -- with an accuracy of 20m
```
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

// Function to delete all markers
function deleteMarkers (markersArray) {
  for (var i = 0; i < markersArray.length; i++) {
    markersArray[i].setMap(null)
  }
  markersArray = []
}
}
})
```
The Arduino codes are available on our github, the coolest bit of code is here where I’m allowed to publish one set of data to the server that can be retained. What this means is that whenever the client first polls the server, there is a readily available set of data that can be retrieved -- which can be useful say for showing last known GPS coordinates when first publishing the web page instead of waiting for the device to poll back.

Currently the web app only features GPS coordinates but the hardware already supports temperature/humidity reading and target threshold temperature setting for the device. Details below

Commands (message) - ‘action’ (topic) 			     - returns
1	 		  - polls the device for GPS coordinates  - returns lat,lng
2:X 	 		  - X to set temperature		     - returns humidity,temperature

|Commands (message)|‘action’ (topic)                    |returns|
|------------------:------------------------------------:------:|
| 1                |polls the device for GPS coordinates|returns lat,lng|
|2:X|X to set temperature|returns humidity,temperature|                

```
From the C++ codes:

  // Publishing the message
    if (dht_message.startsWith("0.0")) {
      client.publish("current_DHT", message_arr);
    }
    else client.publish("current_DHT", message_arr, true);
```

### Additional things I will do

* Implement the deliveryman and Supplier Invoicing System
* Use an event handler like Sidekiq/Resque to improve performance of the active jobs and reduce number of threads
* Introduce more data points like gyroscope data - to allow the device to calibrate food handling
* Use message filters on action cables for multi-user channel support, integrate a user-device authentication workflow
* Drop the use of a broker and host the MQTT server on a localhost server

### Credits

* Prima
* YiSheng
* Sharona
* Jon(WDI-9)
* Cara
* John Ang (the IoT Tony Stark)
* Raymond (our 3rd TA)
* UX TEAM
![UX TEAM](/app/assets/images/ux3.jpeg)
