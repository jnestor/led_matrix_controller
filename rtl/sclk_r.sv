module sclk_r (input logic clk, rst, sclk_r_clr, sclk_r_set,
                output logic sclk);

   always_ff @(posedge clk)
     if (rst || sclk_r_clr) sclk <= 0;
     else if (sclk_r_set) sclk <= 1;
   
endmodule // sclk_r

