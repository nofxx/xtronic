#include <SoftwareSerial.h>

#define rxPin 5
#define txPin 6
#define ledPin 13
byte pinState = 0;

SoftwareSerial eSerial = SoftwareSerial(rxPin, txPin);

void setup() {

  pinMode(rxPin, INPUT);
  pinMode(txPin, OUTPUT);
  pinMode(ledPin, OUTPUT);

  // initialize both serial ports:
  Serial.begin(115200);
  eSerial.begin(9600);

  Serial.println("START");
}

void loop() { // mirror each char from eSerial to Serial
  char vchar = eSerial.read();
  Serial.print(vchar);
  if(vchar)
    toggle(13);
}

void toggle(int pinNum) {
  digitalWrite(pinNum, pinState);
  pinState = !pinState;
}
