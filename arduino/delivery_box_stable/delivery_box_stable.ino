#include <TinyGPS++.h>                                  // Tiny GPS Plus Library
#include <SoftwareSerial.h>                             // Software Serial Library so we can use other Pins for communication with the GPS module
#include <PubSubClient.h>                               // for Websockets broker
#include <ESP8266WiFi.h>                                // for ESP8266 to Wifi

#include <Adafruit_ssd1306syp.h>                        // Adafruit oled library for display
Adafruit_ssd1306syp display(4,5);                       // OLED display (SDA to Pin 4), (SCL to Pin 5)

/* wiring the UBLOX NEO-6M + OLED to ESP8266 (WeMos D1 Mini)
RX      = TX
TX      = RX
SDA     = D2
SCL     = D1
GND     = GND
VCC      = 5V
*/

static const int RXPin = RX, TXPin = TX;                // Ublox 6m GPS module to pins 12 and 13
static const uint32_t GPSBaud = 9600;                   // Ublox GPS default Baud Rate is 9600

const double Home_LAT = 1.306101;                      // Your Home Latitude
const double Home_LNG = 103.90341;                     // Your Home Longitude

TinyGPSPlus gps;                                        // Create an Instance of the TinyGPS++ object called gps
SoftwareSerial ss(RXPin, TXPin);                        // The serial connection to the GPS device

/* WIFI SSID/PASS*/
//const char* ssid = "GA@Spacemob";
//const char* password = "yellowpencil";

//const char* ssid = "chewchew";
//const char* password = "chewkumwing";

//const char* ssid = "iPhone (5)";
//const char* password = "abrasion";

const char* ssid = "The Prototyping Lab";
const char* password = "OMG188969";

/*MQTT USER/PASS*/
const char* mqtt_server = "m13.cloudmqtt.com";
const int mqtt_port = 14188;
const char* mqtt_user = "lnpapqmm";
const char* mqtt_pass = "vQmZfvY1tHUc";

WiFiClient espClient;
PubSubClient client(espClient);
long lastMsg = 0;
char msg[50];
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
  pinMode(BUILTIN_LED, OUTPUT);     // Initialize the BUILTIN_LED pin as an output
  digitalWrite(BUILTIN_LED, HIGH);   // Turn the LED off

  setup_wifi();

  client.setServer(mqtt_server, mqtt_port);
  client.setCallback(callback);
  display.println("Set client-MQTT servers");
  display.update();
}

void loop() {
  // keep client connected
  if (!client.connected()) {
    reconnect();
  }
  client.loop();

  // display output on OLED
  display.clear();
  display.setCursor(0,0);
  display.print("Latitude  : ");
  display.println(gps.location.lat(), 5);
  display.print("Longitude : ");
  display.println(gps.location.lng(), 4);
  display.print("Satellites: ");
  display.println(gps.satellites.value());
  display.print("Elevation : ");
  display.print(gps.altitude.feet());
  display.println("ft");
  display.print("Time UTC  : ");
  display.print(gps.time.hour());                       // GPS time UTC
  display.print(":");
  display.print(gps.time.minute());                     // Minutes
  display.print(":");
  display.println(gps.time.second());                   // Seconds
  display.print("Heading   : ");
  display.println(gps.course.deg());
  display.print("Speed     : ");
  display.println(gps.speed.mph());

  unsigned long Distance_To_Home = (unsigned long)TinyGPSPlus::distanceBetween(gps.location.lat(),gps.location.lng(),Home_LAT, Home_LNG);
  display.print("M to Home: ");                        // Have TinyGPS Calculate distance to home and display it
  display.print(Distance_To_Home);
  display.update();                                     // Update display
  delay(200);

  smartDelay(500);                                      // Run Procedure smartDelay

  if (millis() > 5000 && gps.charsProcessed() < 10)
    display.println(F("No GPS data received: check wiring"));
}

static void smartDelay(unsigned long ms)                // This custom version of delay() ensures that the gps object is being "fed".
{
  unsigned long start = millis();
  do
  {
    while (ss.available())
      gps.encode(ss.read());
  } while (millis() - start < ms);
}

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

void callback(char* topic, byte* payload, unsigned int length) {
  Serial.print("Message arrived [");
  Serial.print(topic);
  Serial.print("] ");
  for (int i = 0; i < length; i++) {
    Serial.print((char)payload[i]);
  }

  // Switch on the LED if an 1 was received as first character
  if ((char)payload[0] == '1') {
    display.clear();
    display.setCursor(0,0);
    display.println("received 1");
    display.update();
    digitalWrite(BUILTIN_LED, LOW);   // Turn the LED on (Note that LOW is the voltage level

  // Preparing for mqtt send
    String gpslat_str = String(gps.location.lat(),5);
    display.println(gpslat_str.substring(0,7));
    display.update();
//    delay(2000);
    String gpslong_str = String(gps.location.lng(),5);
    display.println(gpslong_str.substring(0,9));
    display.update();
//    delay(2000);
    char message_arr[18];
    String message = gpslat_str.substring(0,7) + "," + gpslong_str.substring(0,9);

    display.println(message);
    display.update();
//    delay(2000);
    display.println(message.length()+1);
    display.update();
    delay(2000);
    message.toCharArray(message_arr, message.length() + 1); //packaging up the data to publish to mqtt whoa...

  // Publishing the message
    client.publish("current_GPS", message_arr);
    display.println("message sent");
    display.update();
    digitalWrite(BUILTIN_LED, HIGH);   // Turn the LED off
//    digitalWrite(D8, LOW);

  } else {
    display.println("received nothing");
    display.update();
    digitalWrite(BUILTIN_LED, HIGH);  // Turn the LED off by making the voltage HIGH
//    digitalWrite(D8, LOW);

  }

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
