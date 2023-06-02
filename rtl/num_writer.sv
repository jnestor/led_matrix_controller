module num_writer (input logic clk, rst, nextbtn,
           input logic [2:0] num_color,
		   output logic numcol_we,
		   output logic [31:0] numcol_out,
		   output logic [9:0] numcol_addr,
		   output logic [3:0] digit);

   parameter NUMCOL_OFFSET = 172;

   logic 			      nextbtn_db, nextbtn_pulse, enb_digit_ctr;
   logic 			      clr_numcol_ctr, enb_numcol_ctr, numcol_done;
   
   logic [3:0] 			      digit_ct;
   logic [2:0] 			      numcol_ct;

   debounce U_DB (.clk, .pb(nextbtn), .pb_debounced(nextbtn_db));

   single_pulser U_SP (.clk, .din(nextbtn_db), .d_pulse(nextbtn_pulse));

   num_writer_fsm U_NWFSM (.clk, .rst, .nextbtn_pulse, .numcol_done,
                  .clr_numcol_ctr, .enb_numcol_ctr, .numcol_we);
   
   digit_ctr U_DGCTR (.clk, .rst, .enb_digit_ctr(nextbtn_pulse), .digit_ct);

   numcol_ctr U_NCCTR (.clk, .rst, .clr_numcol_ctr, .enb_numcol_ctr, .numcol_ct, .numcol_ctr_done(numcol_done));
   
   digit_generator U_DG (.num(digit_ct), .num_color, .numcol_index(numcol_ct), .col_out(numcol_out));

   assign numcol_addr = NUMCOL_OFFSET + numcol_ct;
   
   assign digit = digit_ct;  // temporary display for debugging

endmodule // num_writer
