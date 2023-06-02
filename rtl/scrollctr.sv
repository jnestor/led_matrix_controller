module scrollctr (input logic clk, rst, scrollct_clr, scrollct_enb,
                output logic [9:0] scrollct,
                output logic scrollct_done);

   parameter MAX_SCROLL_COL=450;

   assign scrollct_done = (scrollct == MAX_SCROLL_COL);

   always_ff @(posedge clk)
     if (rst || scrollct_clr || scrollct_done) scrollct <= 0;
     else if (scrollct_enb) scrollct <= scrollct + 1;
     else scrollct <= scrollct;

endmodule // scrollctr
