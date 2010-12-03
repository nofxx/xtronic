/*
 * A simple sketch that uses WiServer to serve a web page
 */


#include <WiServer.h>

#define WIRELESS_MODE_INFRA 1
#define WIRELESS_MODE_ADHOC 2

#define SEC  1000
#define MIN  60000
#define HOUR 3600000
#define DAY  86400000
#define MAX  50

#define CAM_DELAY 750

const int phonyGND = 7;
const int shootLed = 6;
const int shootPin = 5;
const int focusPin = 4;
const int shootBtn = 3;
const int extraLed = 2;

// Wireless configuration parameters ----------------------------------------
unsigned char local_ip[] = {192,168,1,2}; // IP address of WiShield
unsigned char gateway_ip[] = {192,168,1,1}; // router or gateway IP address
unsigned char subnet_mask[] = {255,255,255,0};  // subnet mask for the local network
const prog_char ssid[] PROGMEM = {"SHOOT"};   // max 32 bytes

unsigned char security_type = 0;  // 0 - open; 1 - WEP; 2 - WPA; 3 - WPA2

// WPA/WPA2 passphrase
const prog_char security_passphrase[] PROGMEM = {"12345678"}; // max 64 characters

// WEP 128-bit keys
// sample HEX keys
prog_uchar wep_keys[] PROGMEM = { 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, // Key 0
          0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // Key 1
          0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // Key 2
          0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00  // Key 3
        };

// setup the wireless mode
// infrastructure - connect to AP
// adhoc - connect to another WiFi device
unsigned char wireless_mode = WIRELESS_MODE_ADHOC;

unsigned char ssid_len;
unsigned char security_passphrase_len;
// End of wireless configuration parameters ----------------------------------------


void shoot() {
  digitalWrite(shootPin, HIGH);
  digitalWrite(shootLed, HIGH);
  delay(CAM_DELAY);
  digitalWrite(shootPin, LOW);
  digitalWrite(shootLed, LOW);
}

void focus() {
  digitalWrite(focusPin, HIGH);
  digitalWrite(extraLed, HIGH);
  delay(CAM_DELAY);
  digitalWrite(focusPin, LOW);
  digitalWrite(extraLed, LOW);
}

const prog_char webpage[] PROGMEM = {"<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN''http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'><html xmlns='http://www.w3.org/1999/xhtml' xml:lang='en' lang='en'><head><title> Shooter! </title></head><body><h1> Shooter! </h1><div><form action='./s' method='GET'><input type='submit' value='Shoot!'></input></form><form action='./f' method='GET'><input type='submit' value='Focus'></input></form></div><div><form action='./' method='GET'><input type='text' name='delay'></input><div>Loop<input type='checkbox' name='loop' value='t' /><input type='submit' value='ok'></input></form></div></div>"};

void printFromMem(const prog_char str[])
{
  char c;
  if(!str) return;
  while((c = pgm_read_byte(str++)))
    WiServer.print(c,BYTE);
}


// This is our page serving function that generates web pages
boolean sendMyPage(char* URL) {

  // WiServer.print(webpage);
  //print PROGMEM
  printFromMem(webpage);

  WiServer.print(URL);

  // Check if the requested URL matches "/"
  if (strcmp(URL, "/") == 0) {
    WiServer.print("Hello !!!");

  } else {
    if (strcmp(URL, "S") == 0) {
      shoot();
      WiServer.print("Shooting!");
    }

    if (strcmp(URL, "F") == 0) {
      focus();
      WiServer.print("Focusing!");
    }

    Serial.println("Serving...");
    WiServer.print(URL);

  }
  //"<HTML><HEAD><meta http-equiv='REFRESH' content='0;url=/'></HEAD></HTML>");
  WiServer.print("</body></html>");
  return true;
  // URL not found
  //    return false;
}


void setup() {

  // Use digital pin 7 as GND, WiShield takes 13~8.
  pinMode(phonyGND, OUTPUT);

  pinMode(shootLed, OUTPUT);
  pinMode(shootPin, OUTPUT);
  pinMode(focusPin, OUTPUT);
  pinMode(shootBtn, INPUT);
  pinMode(extraLed, OUTPUT);

  digitalWrite(phonyGND, LOW);

  // Initialize WiServer and have it use the sendMyPage function to serve pages
  WiServer.init(sendMyPage);
  // Enable Serial output and ask WiServer to generate log messages (optional)
  Serial.begin(115200);
  WiServer.enableVerboseMode(true);
}

void loop(){
  // Run WiServer
  WiServer.server_task();
  // delay(10);
}

