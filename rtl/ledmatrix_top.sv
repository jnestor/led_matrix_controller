module ledmatrix_top (
   input logic        clk, rst, nextbtn, pause_btn,
   input logic [2:0]  num_color,
   output logic       sclk, blank, lat,
   output logic [2:0] disp_row, rgb1, rgb2,
   output logic [3:0] digit,
   logic sclk_s, blank_s, lat_s,
   logic [2:0] rgb2_s
   );
   
   // Number of LED matrix units connected in series
   parameter NUM_PANELS = 4;

   logic [2:0] row;
   logic [7:0] col;
   
   
   
   assign sclk_s = sclk;    // for oscope output
   assign blank_s = blank;
   assign lat_s = lat;
   assign rgb2_s = rgb2;

   
   sequencer #(.NUM_PANELS(NUM_PANELS)) U_SEQ(.clk, .rst, .row, .disp_row, .col, .sclk, .blank, .lat);
   
   //pixel_generator_simple(.col, .row, .rgb1, .rgb2);

   pixel_generator U_PIX(.clk, .rst, .nextbtn, .pause_btn(pause_btn), .num_color, .col, .row, .rgb1, .rgb2, .digit);
   
endmodule // ledmatrix_top
