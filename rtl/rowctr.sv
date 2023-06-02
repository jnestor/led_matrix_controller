// disp_row is the row currently being displayed and should be passed to the 

module rowctr (input logic clk, rst, rowct_clr, rowct_enb,
                output logic [2:0] row, disp_row,
                output logic row_eq_7);

   assign row_eq_7 = row  == 7;
   
   always_ff @(posedge clk)
     if (rst || rowct_clr) 
       begin
          row <= 0;
          disp_row <= 7;
       end
     else if (rowct_enb)
       begin
          disp_row <= row;
          row <= row + 1;
      end
endmodule // rowctr
