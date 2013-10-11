int sensorPin = A0;    // select the input pin for the potentiometer
int sensorValue = 0;  // variable to store the value coming from the sensor

void setup() {
   Serial.begin(115200);
   delay(500); 
}

void loop() {
  // read the value from the sensor:
  sensorValue = analogRead(sensorPin);    
 
 //print to port
 Serial.println(sensorValue);

  // wait 2 milliseconds before the next loop
  // for the analog-to-digital converter to settle
  // after the last reading:
  delay(2);  
}
