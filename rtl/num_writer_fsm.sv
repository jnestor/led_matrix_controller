module num_writer_fsm (input logic clk, rst, nextbtn_pulse, numcol_done,
		       output logic clr_numcol_ctr, enb_numcol_ctr, numcol_we);

   enum logic {PBWAIT, WRCOLS} state, next;

   always_ff @(posedge clk)
     if (rst) state <= WRCOLS;  // write 'zero' into framebuffer on reset
     else state <= next;
   
   always_comb
     begin
	clr_numcol_ctr = 0;
	enb_numcol_ctr = 0;
	numcol_we = 0;
	next = PBWAIT;
	case (state) 
	  PBWAIT: begin
	     clr_numcol_ctr = 1;
	     if (nextbtn_pulse) next = WRCOLS;
	     else next = PBWAIT;
	  end
	  WRCOLS: begin
	     enb_numcol_ctr = 1;
	     numcol_we = 0;
	     if (numcol_done) next = PBWAIT;
	     else next = WRCOLS;
	  end
	endcase // case (state)
     end

endmodule // num_writer_fsm
