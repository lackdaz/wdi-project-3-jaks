/*
 Basic ESP8266 MQTT example

 This sketch demonstrates the capabilities of the pubsub library in combination
 with the ESP8266 board/library.

 It connects to an MQTT server then:
  - publishes "hello world" to the topic "outTopic" every two seconds
  - subscribes to the topic "inTopic", printing out any messages
    it receives. NB - it assumes the received payloads are strings not binary
  - If the first character of the topic "inTopic" is an 1, switch ON the ESP Led,
    else switch it off

 It will reconnect to the server if the connection is lost using a blocking
 reconnect function. See the 'mqtt_reconnect_nonblocking' example for how to
 achieve the same result without blocking the main loop.

 To install the ESP8266 board, (using Arduino 1.6.4+):
  - Add the following 3rd party board manager under "File -> Preferences -> Additional Boards Manager URLs":
       http://arduino.esp8266.com/stable/package_esp8266com_index.json
  - Open the "Tools -> Board -> Board Manager" and click install for the ESP8266"
  - Select your ESP8266 in "Tools -> Board"

*/

#include <ESP8266WiFi.h>
#include <PubSubClient.h>

// Update these with values suitable for your network.

/* WIFI SSID/PASS*/
const char* ssid = "GA@Spacemob";
const char* password = "yellowpencil";

//const char* ssid = "chewchew";
//const char* password = "chewkumwing";

//const char* ssid = "iPhone (5)";
//const char* password = "abrasion";

/*MQTT USER/PASS*/
const char* mqtt_server = "m13.cloudmqtt.com";
const int   mqtt_port = 14188;
const char* mqtt_user = "lnpapqmm";
const char* mqtt_pass = "vQmZfvY1tHUc";

String gpsCoords[] =
{
"1.304664,103.832487",
"1.304259,103.833324",
"1.303840,103.834118",
"1.303444,103.834901",
"1.303004,103.835673",
"1.302961,103.835845",
"1.303057,103.835963",
"1.303991,103.836403",
"1.305010,103.836918",
"1.305675,103.837411",
"1.305889,103.837605",
"1.306157,103.837594",
"1.307150,103.837184",
"1.308255,103.836808",
"1.309413,103.836390",
"1.310405,103.835813",
"1.310518,103.835564",
"1.310432,103.835317",
"1.310362,103.835043",
"1.309847,103.834303",
"1.309123,103.833836",
"1.308932,103.833708",
"1.308973,103.833514",
"1.309268,103.832951",
"1.309558,103.832318",
"1.309565,103.832181",
"1.309483,103.832114",
"1.308699,103.831953",
"1.308128,103.831776",
"1.307782,103.831572",
"1.307806,103.831592"
};

int pos;
bool runnerState = false;

WiFiClient espClient;
PubSubClient client(espClient);
long lastMsg = 0;
char msg[50];
int value = 0;

void setup() {
  pinMode(BUILTIN_LED, OUTPUT);     // Initialize the BUILTIN_LED pin as an output
  Serial.begin(115200);
  setup_wifi();
  client.setServer(mqtt_server, mqtt_port);
  client.setCallback(callback);
  pos = 0;
}

void setup_wifi() {

  delay(10);
  // We start by connecting to a WiFi network
  Serial.println();
  Serial.print("Connecting to ");
  Serial.println(ssid);

  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  Serial.println("");
  Serial.println("WiFi connected");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());
}

void callback(char* topic, byte* payload, unsigned int length) {
  Serial.print("Message arrived [");
  Serial.print(topic);
  Serial.print("] ");
  for (int i = 0; i < length; i++) {
    Serial.print((char)payload[i]);
  }
  Serial.println();

  // Switch on the LED if an 3 was received as first character
  if ((char)payload[0] == '3') {
    digitalWrite(BUILTIN_LED, LOW);   // Turn the LED on (Note that LOW is the voltage level
    runnerState = true;
    delay(1000);
  } else {
    digitalWrite(BUILTIN_LED, HIGH);  // Turn the LED off by making the voltage HIGH
  }

}

void reconnect() {
  // Loop until we're reconnected
  while (!client.connected()) {
    Serial.print("Attempting MQTT connection...");
    // Attempt to connect
    digitalWrite(BUILTIN_LED, HIGH);  // Turn the LED off by making the voltage HIGH
    delay(50);
    digitalWrite(BUILTIN_LED, LOW);  // Turn the LED off by making the voltage HIGH
    delay(50);
    if (client.connect("ESP8266Client",mqtt_user,mqtt_pass)) {
      Serial.println("connected");
      digitalWrite(BUILTIN_LED, HIGH);  // Turn the LED off by making the voltage HIGH
      // Once connected, publish an announcement...
      client.publish("action", "hello world");
      // ... and resubscribe
      client.subscribe("action");
    } else {
      Serial.print("failed, rc=");
      Serial.print(client.state());
      Serial.println(" try again in 5 seconds");
      // Wait 5 seconds before retrying
      delay(5000);
    }
  }
}
void loop() {

  if (!client.connected()) {
    reconnect();
  }
  client.loop();

  char message_arr[18];


  if (!runnerState) {
    delay(50);
    return;
  }

  if (pos == sizeof(gpsCoords)/sizeof(gpsCoords[0])) {
    runnerState = false;
    pos = 0;
    String message = "FIN";
    message.toCharArray(message_arr,message.length() + 1);
    client.publish("action", message_arr);
    delay(50);
    return;
  }

  long now = millis();
  if (now - lastMsg > 1500) {
    lastMsg = now;

//    String gps_message = String(gpsCoords[pos]);
    String gps_message = gpsCoords[pos];
    gps_message.toCharArray(message_arr, gps_message.length() + 1);

    Serial.print("Publish message: ");
    Serial.println(gps_message);
    client.publish("current_GPS", message_arr);
    pos++;

  }
}
