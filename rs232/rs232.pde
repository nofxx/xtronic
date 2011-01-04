#include <SoftwareSerial.h>

#define mcuBauds 9600
#define cpuBauds 115200

#define rxPin 5
#define txPin 6
#define ledPin 13


SoftwareSerial eSerial = SoftwareSerial(rxPin, txPin);

void setup() {

  pinMode(rxPin, INPUT);
  pinMode(txPin, OUTPUT);
  pinMode(ledPin, OUTPUT);

  // initialize both serial ports:
  Serial.begin(cpuBauds);
  eSerial.begin(mcuBauds);

  Serial.println("START");
}

void loop() { // mirror each char from eSerial to Serial
  char vchar = eSerial.read();
  Serial.print(vchar);
  // if(vchar)
  //   toggle(13);
}

void toggle(int pinNum) {
  // blink led
}
