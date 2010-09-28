/*
 * Shooter v1
 *
 *
 *
 *
 *
 */

#define SEC  1000
#define MIN  60000
#define HOUR 3600000
#define DAY  86400000
#define MAX  50

// Output
const int rxPin = 0;
const int txPin = 1;
const int d2 = 2;
const int d3 = 3;
const int d4 = 4;
const int d5 = 5;
const int d6 = 6;
const int d7 = 7;
const int d8 = 8;
const int d9 = 9;
//const int d10 = 10;
//const int d11 = 11;
//const int d12 = 12;
const int infoPin = 13;

// Input
const int i0 = A0;
const int i1 = A1;
const int i2 = A2;
const int i3 = A3;
const int i4 = A4;
const int i5 = A5;
// Digital
const int d10 = 10;
const int d11 = 11;
const int d12 = 12;

// Intervals (s)
unsigned long shoot = 1;
unsigned long sync  = 5 * SEC;
unsigned long time_now, last_shoot, last_sync;

int i = 0;
int btnState = 0;
int touchState = 0;

char outbuf[MAX];
char cmdbuf[MAX];

volatile int rx_state = LOW;
volatile int tx_state = LOW;


unsigned long mintomilli(unsigned long m) {
  return(m * 60000);
}

int ctoi( int c )
{
  return c - '0';
}

void read_commands() {
  char c;
  while( Serial.available() && c != '\n' ) {  // buffer up a line
    c = Serial.read();
    if (c == '\n' || c == ',') {
      focus();
    } else if (c == 'x') {
      shoot();
    } else {
      cmdbuf[i++] = c;
    }
  }
}

void setup()  {
  // Atmega defaults INPUT
  pinMode(infoPin, OUTPUT);
  pinMode(d2, OUTPUT);
  pinMode(d3, OUTPUT);
  pinMode(d4, OUTPUT);
  pinMode(d5, OUTPUT);
  pinMode(d6, OUTPUT);
  pinMode(d7, OUTPUT);
  pinMode(d10, OUTPUT);

  // testFalse();
  shoot = mintomilli(shoot);

  //  attachInterrupt(0, btnLed, CHANGE);
  Serial.begin(115200);
}


void loop()  {
  time_now = millis();

  read_commands();
  if ( abs(time_now - last_shoot) >= shoot) {
    last_shoot = time_now;
    //  Serial.println("SHOOTING");
    digitalWrite(d6, HIGH);  // turn the d6 on
    delay(400);                  // stop the program for some time
    digitalWrite(d6, LOW);   // turn the d6 off
  }

  // Sync over wire
  if ( abs(time_now - last_sync) >= sync) {
    last_sync = time_now;
    read_sensors();
  }


}
