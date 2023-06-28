module num_writer_fsm (input logic clk, rst, nextbtn_pulse, numcol_done,
		       output logic clr_numcol_ctr, enb_numcol_ctr,
                       output logic [3:0] numcol_we); // changed numcol_we to 4 bits since we are writing 4 bit rgb values

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
	     numcol_we = 4'b1111; // enabled each bit of the write input enable in frame buffer,overiding the 4'b0000 configuration in pixelram.sv
	     if (numcol_done) next = PBWAIT;
	     else next = WRCOLS;
	  end
	endcase // case (state)
     end

endmodule // num_writer_fsm
