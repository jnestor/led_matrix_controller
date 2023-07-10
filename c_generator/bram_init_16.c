#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "char_map.h"

#define BRAM_COLS 4096


#define MSG_LIMIT 682

// write an INIT message
void write_init(unsigned int init_num, unsigned int init_buf [8], unsigned int color_mask) {
    printf(".INIT_%02X (256'h", init_num);
    for (int i=7; i >0; i--) {
	printf("%08X_", init_buf[i] & color_mask);
    }
    printf("%08X),\n", init_buf[0] & color_mask);
}

// 8 columns per INIT parameter

// write a string of characters into a series of Xilinx BRAM INIT statements
void write_bram_init(char msg[], unsigned int color_mask, unsigned int col_offset) {
  unsigned int init_num = col_offset / 8;
  unsigned int init_buf [8];
  unsigned int i = 0;
  unsigned int init_col = 0;
  unsigned char c;

  //Go through the whole message twice to create init file for top and bottom display

  for(int k = 0; k < 2; k++){
    printf("Generating init %d\n\r", k+1);
    init_col = 0;
    i = 0;
    init_num = col_offset / 8;
    //While there's still stuff in the message
    while ( (i < MSG_LIMIT) && ((c = msg[i]) != 0) ) {
      //Grab each column of the letter
      //If we're on the first time through
      if(k == 0){
        for (int j=0; j<CHAR_WIDTH; j++) {
          init_buf[init_col] = char_map_16[c][j];
          //We got to the end of the char
          //Print the message out, move to next
          if (init_col == 7) {
            write_init(init_num, init_buf, color_mask);
            init_col = 0;
            init_num++;
          } else init_col++;
        }
      //We are on the second time through so we want the data from the second half, offset by 6
      }else{
        for (int j=0; j<CHAR_WIDTH; j++) {
          init_buf[init_col] = char_map_16[c][j + CHAR_WIDTH];
          //We got to the end of the char
          //Print the message out, move to next
          if (init_col == 7) {
            write_init(init_num, init_buf, color_mask);
            init_col = 0;
            init_num++;
          } else init_col++;
        }
      }
      //Next char
      i++;
    }
    // fill up remaining columns for last "init_col"
    if (init_col>0) {
      while (init_col<=7) {
        init_buf[init_col++] = 0;
      }
      write_init(init_num, init_buf, color_mask);
    }
  }
}

#define DEFAULT_STRING "[]~`!@#$%^&*()_+=-?><,.{}|\":;'"
#define DEFAULT_MASK 0x66666666 //
#define DEFAULT_OFFSET 256
#define MAX_CHARS 1024 / 8


int main(int argc, char *argv[]) {
    char *msg;
    unsigned int mask;
    unsigned int col_offset;

    msg = DEFAULT_STRING;
    mask = DEFAULT_MASK;
    col_offset = DEFAULT_OFFSET;
    printf("argc=%d\n", argc);
    if (argc >= 2) {
	msg = argv[1];
	if (strlen(msg) > MAX_CHARS)
	    printf("Input m too long; will truncate");
    }
    if (argc >= 3) {
	if (sscanf_s(argv[2], "%x",&mask) == 0) {
	    printf("Illegal mask argument %s", argv[2]);
	    exit(1);
	}
    }
    if (argc == 4) {
	if (sscanf_s(argv[3], "%d", &col_offset) == 0) {
	    printf("Illegal column offset argument %s\n", argv[3]);
	    exit(1);
	}
    }
    printf("message: %s mask=%x col_offset=%d\n", msg, mask, col_offset);
    write_bram_init(msg, mask, col_offset);
    return (0);
}
