module colctr (input logic clk, rst, colct_clr, colct_enb,
                output logic [7:0] col,
                output logic colct_eq_31);

   assign colct_eq_31 = col == 255;
   
   always_ff @(posedge clk)
     if (rst || colct_clr) col = 0;
     else if (colct_enb) col = col + 1;
      
endmodule // colctr
