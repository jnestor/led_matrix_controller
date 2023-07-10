/* This file contains the declaration for the char_map data structure.  You should
 * include it in your program using the C preprocessor directive:
 *    #include "char_map.h"
 * You should compile your program using the command
 *    gcc char_map.c bram_init.c -o bram_init
 *
 */

#define CHAR_WIDTH 8

//extern unsigned int char_map [128][CHAR_WIDTH];
//extern unsigned int top_bottom_char_map[128][12];

extern unsigned int char_map_16[128][CHAR_WIDTH*2];

