module numcol_ctr (input logic clk, rst, clr_numcol_ctr, enb_numcol_ctr,
		   output logic [2:0] numcol_ct,
		   output logic       numcol_ctr_done);

   assign numcol_ctr_done = (numcol_ct == 5);

   always_ff @(posedge clk)
     if (rst || clr_numcol_ctr) numcol_ct <= 0;
     else if (enb_numcol_ctr) numcol_ct <= numcol_ct + 1;

endmodule // numcol_ctr


   