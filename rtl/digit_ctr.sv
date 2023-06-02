module digit_ctr (input logic clk, rst, enb_digit_ctr,
		  output logic [3:0] digit_ct);

   logic 			     digit_ctr_done;

   assign digit_ctr_done = (digit_ct == 9);
   
   always_ff @(posedge clk)
     if (rst) digit_ct <= 0;
     else if (enb_digit_ctr)
       begin
         if (digit_ctr_done) digit_ct <= 0;
         else digit_ct <= digit_ct + 1;
       end

endmodule // digit_ctr


   