#include <Arduino.h>
#include <ESP32Servo.h>
#include <WiFi.h>
#include <AsyncTCP.h>
#include <ESPAsyncWebServer.h>
#include <./secrets.h>

AsyncWebServer server(80);

const char *hostname = "esp32-puppet-arm";

const char *PARAM_ANGLE = "angle";

Servo myservo1;
Servo myservo2;
Servo myservo3;

// // Possible PWM GPIO pins on the ESP32: 0(used by on-board button),2,4,5(used by on-board LED),12-19,21-23,25-27,32-33
int servo1Pin = 12; // GPIO pin used to connect the servo control (digital out)
int servo2Pin = 14;
int servo3Pin = 27;
// // Possible ADC pins on the ESP32: 0,2,4,12-15,32-39; 34-39 are recommended for analog input
int ADC_Max = 4096; // This is the default ADC max value on the ESP32 (12 bit ADC width);
                    // this width can be set (in low-level oode) from 9-12 bits, for a
                    // a range of max values of 512-4096

int val; // variable to read the value from the analog pin

void notFound(AsyncWebServerRequest *request)
{
  request->send(404, "text/plain", "Not found");
}

void setup()
{
  Serial.begin(9600);
  WiFi.mode(WIFI_STA);
  WiFi.setHostname(hostname);
  delay(200);
  WiFi.begin(ssid, password);
  if (WiFi.waitForConnectResult() != WL_CONNECTED)
  {
    Serial.printf("WiFi Failed!\n");
    return;
  }

  Serial.print("IP Address: ");
  Serial.println(WiFi.localIP());

  server.on("/", HTTP_GET, [](AsyncWebServerRequest *request) {
    request->send(200, "text/plain", "Hello, world");
  });

  server.on("/servo1", HTTP_POST, [](AsyncWebServerRequest *request) {
    String message;
    if (request->hasParam(PARAM_ANGLE, true))
    {
      message = request->getParam(PARAM_ANGLE, true)->value();
      Serial.println("POST to /servo1");
      Serial.println(message);
      myservo1.write(message.toInt());
    }
    request->send(200, "text/plain", "Moving To Angle");
  });

  server.on("/servo2", HTTP_POST, [](AsyncWebServerRequest *request) {
    String message;
    if (request->hasParam(PARAM_ANGLE, true))
    {
      message = request->getParam(PARAM_ANGLE, true)->value();
      Serial.println("POST to /servo2");
      Serial.println(message);
      myservo2.write(message.toInt());
    }
    request->send(200, "text/plain", "Moving To Angle");
  });

  server.on("/servo3", HTTP_POST, [](AsyncWebServerRequest *request) {
    String message;
    if (request->hasParam(PARAM_ANGLE, true))
    {
      message = request->getParam(PARAM_ANGLE, true)->value();
      Serial.println("POST to /servo3");
      Serial.println(message);
      myservo3.write(message.toInt());
    }
    request->send(200, "text/plain", "Moving To Angle");
  });

  server.onNotFound(notFound);

  server.begin();

  // Allow allocation of all timers
  ESP32PWM::allocateTimer(0);
  ESP32PWM::allocateTimer(1);
  ESP32PWM::allocateTimer(2);
  ESP32PWM::allocateTimer(3);
  myservo1.setPeriodHertz(50);           // Standard 50hz servo
  myservo1.attach(servo1Pin, 500, 2400); // attaches the servo on pin 18 to the servo object
                                         // using SG90 servo min/max of 500us and 2400us
                                         // for MG995 large servo, use 1000us and 2000us,
                                         // which are the defaults, so this line could be
                                         // "myservo.attach(servoPin);"

  myservo2.setPeriodHertz(50);
  myservo2.attach(servo2Pin, 500, 2400);

  myservo3.setPeriodHertz(50);
  myservo3.attach(servo3Pin, 500, 2400);

  delay(2000);
  Serial.println("Booting...");
}

void loop()
{
  //val = random(ADC_Max); // read the value of the potentiometer (value between 0 and 1023)
  //Serial.println("Looping...3");
  //Serial.println(val);
  //val = map(val, 0, ADC_Max, 0, 180); // scale it to use it with the servo (value between 0 and 180)
  //myservo.write(val);                 // set the servo position according to the scaled value
  // myservo1.write(90);
  // delay(2000); // wait for the servo to get there
  // myservo2.write(90);
  // delay(2000);
  // myservo3.write(90);
  // delay(2000);
}
