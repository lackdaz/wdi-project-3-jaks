/* Arduino compiler code for a GPS + DHT22 sensor array powered by a ESP8266 for a Ruby on Rails Web Development Project

Adapted base GPS code from mkconer: https://github.com/mkconer/ESP8266_GPS

Wifi, WebSockets brokered by CloudMQTT, adapted from my previous code: https://github.com/lackdaz/wdi-project-2/blob/master/thing.ino

Author: Seth (lackdaz)
Teammates:
Kenneth
Alvin
Jerel
 */

#include <TinyGPS++.h>                                  // Tiny GPS Plus Library
#include <SoftwareSerial.h>                             // Software Serial Library so we can use other Pins for communication with the GPS module
#include <PubSubClient.h>                               // for Websockets broker
#include <ESP8266WiFi.h>                                // for ESP8266 to Wifi

#include <Adafruit_Sensor.h>                            // For sensors
#include <DHT.h>                                        // For DHT sensors
#include <DHT_U.h>

#include <Adafruit_ssd1306syp.h>                        // Adafruit oled library for display
Adafruit_ssd1306syp display(4,5);                       // OLED display (SDA to Pin 4), (SCL to Pin 5)

// Uncomment the type of sensor in use:
//#define DHTTYPE           DHT11     // DHT 11
#define DHTTYPE           DHT22     // DHT 22 (AM2302)
//#define DHTTYPE           DHT21     // DHT 21 (AM2301)

/* wiring the UBLOX NEO-6M + OLED to ESP8266 (WeMos D1 Mini)
RX      = TX
TX      = RX
SDA     = D2
SCL     = D1
GND     = GND
VCC     = 5V

buzzer  = D5
DHTPIN  = D4
*/

// Pin Assignments
static const int RXPin = RX, TXPin = TX;                // Ublox 6m GPS module to pins 12 and 13
#define DHTPIN D6         // Pin which is connected to the DHT sensor.
#define buzzer D5         // Pin connect to the DHT sensor

static const uint32_t GPSBaud = 9600;                   // Ublox GPS default Baud Rate is 9600

/* VARIABLES */
/*Setting home locations */
const double Home_LAT = 1.306101;                      // Your Home Latitude
const double Home_LNG = 103.90341;                     // Your Home Longitude

/* WIFI SSID/PASS*/
const char* ssid = "GA@Spacemob";
const char* password = "yellowpencil";

//const char* ssid = "chewchew";
//const char* password = "chewkumwing";

//const char* ssid = "iPhone (5)";
//const char* password = "abrasion";

/*MQTT USER/PASS*/
const char* mqtt_server = "m13.cloudmqtt.com";
const int mqtt_port = 14188;
const char* mqtt_user = "lnpapqmm";
const char* mqtt_pass = "vQmZfvY1tHUc";

/* Initializing library routines */
// For GPS
TinyGPSPlus gps;                                        // Create an Instance of the TinyGPS++ object called gps
SoftwareSerial ss(RXPin, TXPin);                        // The serial connection to the GPS device

// For Temperature/Humidity (DHT) Sensors
DHT_Unified dht(DHTPIN, DHTTYPE);
uint32_t delayMS;
sensor_t sensor;
String target_temp;
float temp_reading;
float hum_reading;
unsigned long start_dht = millis();

// For Wifi
WiFiClient espClient;
PubSubClient client(espClient);
long lastMsg = 0;
char msg[50];
int dump[30];
int value = 0;


void setup()
{
  display.initialize();                                 // Initialize OLED display
  display.clear();                                      // Clear OLED display
  display.setTextSize(1);                               // Set OLED text size to small
  display.setTextColor(WHITE);                          // Set OLED color to White
  display.setCursor(0,0);                               // Set cursor to 0,0
  display.println("GPS example");
  display.println(TinyGPSPlus::libraryVersion());
  display.println("TEAM JAKS");
  display.println("Prototype V1.1");
  display.update();                                     // Update display
  delay(1500);                                          // Pause 1.5 seconds
  ss.begin(GPSBaud);                                    // Set Software Serial Comm Speed to 9600

  /* Assigning output pins */
  pinMode(BUILTIN_LED, OUTPUT);     // Initialize the BUILTIN_LED pin as an output
  pinMode(buzzer, OUTPUT);     // Initialize the BUILTIN_LED pin as an output
  digitalWrite(BUILTIN_LED, HIGH);   // Turn the LED off
  digitalWrite(buzzer, LOW);   // Turn the buzzer off

  /* Wifi Initialise */
  setup_wifi(); // Start the wifi via the helper routine

  /* MQTT Initialise */
  client.setServer(mqtt_server, mqtt_port); // set the mqtt server and ports
  client.setCallback(callback); // set the mqtt callback
  display.println("Set client-MQTT servers");
  display.update();

  /* DHT Initialise */
  dht.begin();  // Turn the sensor on
  // dht_intro(); // More detailed sensor reading specifications
  delayMS = sensor.min_delay / 1000; // Seting of min. delay for DHT sensor (usually 2 secs)

}

void loop() {
  // keep client connected
  if (!client.connected()) {
    reconnect(); // This is to reconnect MQTT if disc.
  }
  client.loop(); // call this to check to check for connection

/* Start of GPS routine */
  // display output on OLED
  display.clear();
  display.setCursor(0,0);
  display.print("Latitude  : ");
  display.println(gps.location.lat(), 5);
  display.print("Longitude : ");
  display.println(gps.location.lng(), 4);
  display.print("Satellites: ");
  display.println(gps.satellites.value());
//  display.print("Elevation : ");
//  display.print(gps.altitude.feet());
//  display.println("ft");
  display.print("Time UTC  : ");
  display.print(gps.time.hour());                       // GPS time UTC
  display.print(":");
  display.print(gps.time.minute());                     // Minutes
  display.print(":");
  display.println(gps.time.second());                   // Seconds
//  display.print("Heading   : ");
//  display.println(gps.course.deg());
//  display.print("Speed     : ");
//  display.println(gps.speed.mph());
  display.print("Target Temp : ");
  display.print(target_temp);
  display.println("*C");

  unsigned long Distance_To_Home = (unsigned long)TinyGPSPlus::distanceBetween(gps.location.lat(),gps.location.lng(),Home_LAT, Home_LNG);
  display.print("M to Home: ");                        // Have TinyGPS Calculate distance to home and display it
  display.println(Distance_To_Home);
//  display.update();                                     // Update display

/* End of GPS routine */

/* Start of DHT routine */
//    display.println(millis()-start_dht);   // call this to check for min. delay needed for DHT sensor

// Checks if time < min. delay (TRUE => return and do not take reading)
if (millis() - start_dht < delayMS) {
    display.print("Temperature: ");
    if (isnan(temp_reading)) {   // unlikely, but will display zero for first value
    display.print("NA");
    }
    else display.print(temp_reading);
    display.println("*C");
    display.print("Humidity: ");
    if (isnan(hum_reading)) {
    display.print("NA");
    }
    else display.print(hum_reading);
    display.println("%");
    display.update();
    return;
}

  // Get temperature event and print its value.
  sensors_event_t event;
  dht.temperature().getEvent(&event);
  if (isnan(event.temperature)) {
    Serial.println("Error reading temperature!");
    display.print("Error reading temperature!");
    display.update();
  }
  else {
    Serial.print("Temperature: ");
    temp_reading = event.temperature; // takes and updates temp_reading
    Serial.print(temp_reading);
    Serial.println(" *C");
    display.print("Temperature: ");
    display.print(temp_reading);
    display.println("*C");
  }
  // Get humidity event and print its value.
  dht.humidity().getEvent(&event);
  if (isnan(event.relative_humidity)) {
    Serial.println("Error reading humidity!");
    display.print("Error reading humidity!");
    display.update();
  }
  else {
    Serial.print("Humidity: ");
    hum_reading = event.relative_humidity; // takes and updates hum_reading
    Serial.print(hum_reading);
    Serial.println("%");
    display.print("Humidity: ");
    display.print(hum_reading);
    display.println("%");
    display.update();
  }

  /* real-time logic goes here */
//  if (event.relative_humidity > 65) {
  if (temp_reading > target_temp.toFloat() && target_temp != NULL) {

      tone(buzzer, 1000);   // Turn the SOUND off
  }
  else noTone(buzzer);   // Turn the SOUND off

  // resets timer to count for min. delay again
  start_dht = millis();

/* end of dht routine */

  delay(200); // just leave this delay here

  smartDelay(500);                                      // Run Procedure smartDelay

  if (millis() > 5000 && gps.charsProcessed() < 10)
    display.println(F("No GPS data received: check wiring"));
}

/* END OF VOID LOOP */

/* START OF HELPER ROUTINES */

// Called when message is received
void callback(char* topic, byte* payload, unsigned int length) {
//  display.clear();
//  display.setCursor(0,0);
//  display.print("Message arrived from [");
//  display.print(topic);
//  display.println("] ");
//  display.print("Length: ");
//  display.println(length);
//  display.println("Message: ");
//  for (int i = 0; i < length; i++) {
//    display.print((char)payload[i]);
//  }
//  display.update();
//  delay(5000);

  display.clear();
  display.setCursor(0,0);
  // In order to republish this payload, a copy must be made
  // as the orignal payload buffer will be overwritten whilst
  // constructing the PUBLISH packet.
  // Allocate the correct amount of memory for the payload copy
  byte* p = (byte*)malloc(length);
  // Copy the payload to the new buffer
  memcpy(p,payload,length);
  // converting the array to a string
  String memory_dump((char*)p);
  memory_dump = memory_dump.substring(0,length);
  // removing the ? operator
  display.println(memory_dump);
  display.update();
  // Free the memory
//  delay(5000);
  free(p);

  if ((char)payload[0] == '2') {
    display.clear();
    display.setCursor(0,0);
    display.print("saving temp..");
    display.println("as ");
    target_temp = memory_dump.substring(2,length);
    display.print(target_temp);
    display.update();
//    delay(500);
  }
  // Switch on the LED if a 1 was received as first character
  if ((char)payload[0] == '1') {
    display.println("received 1");
    display.update();
    digitalWrite(BUILTIN_LED, LOW);   // Turn the LED on (Note that LOW is the voltage level

  // Preparing for mqtt send
    String gpslat_str = String(gps.location.lat(),5);
    display.println(gpslat_str.substring(0,7));
    String gpslong_str = String(gps.location.lng(),5);
    display.println(gpslong_str.substring(0,9));
    display.update();
    char message_arr[18];
    String gps_message = gpslat_str.substring(0,7) + "," + gpslong_str.substring(0,9);

    display.println(gps_message);
    display.print("charCount: ");
    display.println(gps_message.length()+1);
    display.update();

    gps_message.toCharArray(message_arr, gps_message.length() + 1); // packaging up the data to publish to mqtt whoa...

  // Publishing the message
    if (gps_message.startsWith("0.0")) {
      client.publish("current_GPS", message_arr);
    }
    else client.publish("current_GPS", message_arr, true);
    display.println("GPS message sent");
    display.update();
//    delay(500);
    digitalWrite(BUILTIN_LED, HIGH);   // Turn the LED off

    String temp_str = String(temp_reading);
    display.println(temp_str);
    String hum_str = String(hum_reading);
    display.println(hum_str);
    display.update();

    String dht_message = hum_str + "," + temp_str;

    display.println(dht_message);
    display.print("charCount: ");
    display.println(dht_message.length()+1);
    display.update();

    dht_message.toCharArray(message_arr, dht_message.length() + 1); //packaging up the data to publish to mqtt whoa...

  // Publishing the message
    if (dht_message.startsWith("0.0")) {
      client.publish("current_DHT", message_arr);
    }
    else client.publish("current_DHT", message_arr, true);
    display.println("message sent");
    display.update();
    delay(500);
    digitalWrite(BUILTIN_LED, HIGH);   // Turn the LED off
  } else {
    display.println("received nothing");
    display.update();
    digitalWrite(BUILTIN_LED, HIGH);  // Turn the LED off by making the voltage HIGH
//    digitalWrite(D8, LOW);
  }
}

// used to ensure GPS readings has at least 500 ms
static void smartDelay(unsigned long ms)                // This custom version of delay() ensures that the gps object is being "fed".
{
  unsigned long start = millis();
  do
  {
    while (ss.available())
      gps.encode(ss.read());
  } while (millis() - start < ms);
}

// Helper routine to connect to Wifi
void setup_wifi() {

  delay(10);
  // We start by connecting to a WiFi network
  Serial.println();
  Serial.print("Connecting to ");
  display.clear();
  display.setCursor(0,0);
  // Clear OLED display
  display.println("Connecting to");
  Serial.println(ssid);
  display.print(ssid);
  display.update();                                     // Update display

  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
    display.print(".");
    display.update();
  }

  Serial.println("");
  Serial.println("WiFi connected");
  display.println("WiFi connected");
  Serial.println("IP address: ");
  display.println("IP address: ");
  Serial.println(WiFi.localIP());
  display.println(WiFi.localIP());
  display.update();
  delay(2000);
}

void reconnect() {
  // Loop until we're reconnected
  while (!client.connected()) {
    display.clear();
    display.setCursor(0,0);
    Serial.print("Attempting MQTT connection...");
    display.println("Attempting MQTT connection...");
    display.update();

    // Attempt to connect
    if (client.connect("ESP8266Client",mqtt_user,mqtt_pass)) {
      Serial.println("connected");
      display.println("connected");
      display.update();

      // Once connected, publish an announcement...
      client.publish("current_GPS", "hello world");
      // ... and resubscribe
      client.subscribe("action");
      client.loop();

    } else {
      Serial.print("failed, rc=");
      display.println("failed, rc=");
      Serial.print(client.state());
      display.print(client.state());
      Serial.println(" try again in 5 seconds");
      display.println(" try again in 5 seconds");
      display.update();
      if (WiFi.status() != WL_CONNECTED)
      {
      setup_wifi();
      display.println("reconnected to WiFi");
      display.update();
      }

      // Wait 5 seconds before retrying
      delay(5000);
    }
  }
}

void dht_intro() {
    Serial.println("DHTxx Unified Sensor Example");
  // Print temperature sensor details.
  dht.temperature().getSensor(&sensor);
  Serial.println("------------------------------------");
  Serial.println("Temperature");
  Serial.print  ("Sensor:       "); Serial.println(sensor.name);
  Serial.print  ("Driver Ver:   "); Serial.println(sensor.version);
  Serial.print  ("Unique ID:    "); Serial.println(sensor.sensor_id);
  Serial.print  ("Max Value:    "); Serial.print(sensor.max_value); Serial.println(" *C");
  Serial.print  ("Min Value:    "); Serial.print(sensor.min_value); Serial.println(" *C");
  Serial.print  ("Resolution:   "); Serial.print(sensor.resolution); Serial.println(" *C");
  Serial.println("------------------------------------");
  // Print humidity sensor details.
  dht.humidity().getSensor(&sensor);
  Serial.println("------------------------------------");
  Serial.println("Humidity");
  Serial.print  ("Sensor:       "); Serial.println(sensor.name);
  Serial.print  ("Driver Ver:   "); Serial.println(sensor.version);
  Serial.print  ("Unique ID:    "); Serial.println(sensor.sensor_id);
  Serial.print  ("Max Value:    "); Serial.print(sensor.max_value); Serial.println("%");
  Serial.print  ("Min Value:    "); Serial.print(sensor.min_value); Serial.println("%");
  Serial.print  ("Resolution:   "); Serial.print(sensor.resolution); Serial.println("%");
  Serial.println("------------------------------------");
  // Set delay between sensor readings based on sensor details.

}
