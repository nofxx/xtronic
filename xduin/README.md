Xduin
=====

Found myself again in a situation where I need just a couple of more I/O
and mega is kinda overkill. Trying to learn KiCAD too.
Didn't take long to reduce it to this.

I want an arduino with:

* Stuff you can buy and solder easily.
* Schematics and PCB on OSS. (KiCAD, GIT)
* MORE I/O
* CONNECTIVITY..


Features/Issues (Comparing to UNO)!

0.5mm tracks
5mm wider board
Single Side Board

Up to 64Kb*
+10 Digital Outputs (6 PWM)
+2 ADC Inputs

FTDI Cable Connectors


Part List
---------


1x Atmega32 DIP40
1x LM7805
1x LP2950
1x Crystal 16MHZ
2x C 22pF
4x C 100nF
2x PC 100uF
1x Diode Bridge
Resistors: 1k/10k/100k
36 Male/Female headers



Fuses
-----

Atmega32/16Mhz/SPI
hfuse: 0xC8
lfuse: 0x3F



Fork and have fun!


