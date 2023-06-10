module sequencer (input logic clk, rst,
                  output logic [7:0] col,      // col currently being written
                  output logic [2:0] row,      // row currently being written (connect to pixel generator)
                  output logic [2:0] disp_row, // row currently being dislayed (connect to LED matrix)
                  output logic sclk, blank, lat);
                  
   parameter NUM_PANELS = 1;

   logic                        half_enb;  // goes high once every half a period of sclk
   logic                        sclk_r_clr, sclk_r_set, colct_clr, colct_enb, colct_eq_max, rowct_clr, rowct_enb, row_eq_7;
      

   delayunit #(.DELAY_US(5)) U_HALFSCLK (.clk, .rst, .done(half_enb));  // use to sequence SCLK and as timing base for everything else

// use this one for simulation
//   delayunit #(.DELAY_NS(20)) U_HALFSCLK (.clk, .rst, .done(half_enb));  // use to sequence SCLK and as timing base for everything else
   
   rowctr U_ROWCTR (.clk, .rst, .rowct_clr, .rowct_enb, .row, .disp_row, .row_eq_7);

   colctr #(.NUM_PANELS(NUM_PANELS)) U_COLCTR (.clk, .rst, .colct_clr, .colct_enb, .col, .colct_eq_max);

   sclk_r U_SCLK_R (.clk, .rst, .sclk_r_set, .sclk_r_clr, .sclk);

   sequencer_fsm U_SEQ (.clk, .rst, .half_enb, .colct_eq_max,
                        .sclk_r_clr, .sclk_r_set, .rowct_clr,
                        .rowct_enb, .colct_clr, .colct_enb, .blank, .lat);
   
   
endmodule
   
