/*
 * © Marcos Piccinini 2011
 *
 * This file is part of xtronic.
 *
 * xtronic is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * xtronic is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with xtronic.  If not, see <http://www.gnu.org/licenses/>.
 */


#include <string.h>
//#include <util/delay.h>


unsigned char USART_Receive( void ) {
  /* Wait for data to be received */
  while ( !(UCSRA & (1<<RXC)) )
    ;
  /* Get and return received data from buffer */
  return UDR;
}

void USART_Transmit( unsigned char data ) {
  /* Wait for empty transmit buffer */
  while ( !( UCSRA & (1<<UDRE)) )
    ;
  /* Put data into buffer, sends the data */
  UDR = data;
}

void USART_Init( unsigned int baud ) {
  /* Set baud rate */
  UBRRH = (unsigned char)(baud>>8);
  UBRRL = (unsigned char)baud;
  /* Enable receiver and transmitter */
  UCSRB = (1<<RXEN)|(1<<TXEN);
  /* Set frame format: 8data, 2stop bit */
   UCSRC = (1<<URSEL)|(1<<USBS)|(3<<UCSZ0);
  /* 8 data bits, 1 stop bit and no paritety */
  //UCSRC = (1 << UCSZ1) | (1 << UCSZ0);
}

void usart_send_string(char* string) {
   int i;
   for(i = 0; string[i] != '\0'; i++) {
      USART_Transmit(string[i]);
   }
   USART_Transmit(NL);
}


int main(void){

  USART_Init(103); // 9600 at 16Mhz (see table on datasheet for yr xtal)

  for(;;){    /* main event loop */
    usart_send_string("HI!");
    //_delay_ms(1000);
  }
}
