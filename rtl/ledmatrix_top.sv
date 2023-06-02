module ledmatrix_top (input logic        clk, rst, nextbtn, pause_btn,
                      input logic [2:0]  num_color,
                      output logic       sclk, blank, lat,
                      output logic [2:0] disp_row, rgb1, rgb2,
                      output logic [3:0] digit);

   logic [2:0] row;
   logic [7:0] col;

   
   sequencer U_SEQ(.clk, .rst, .row, .disp_row, .col, .sclk, .blank, .lat);

   pixel_generator U_PIX(.clk, .rst, .nextbtn, .pause_btn(pause_btn), .num_color, .col, .row, .rgb1, .rgb2, .digit);
   
endmodule // ledmatrix_top
