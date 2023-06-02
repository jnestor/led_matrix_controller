module pixel_generator ( input logic clk, rst, nextbtn, pause_btn, 
                         input logic [2:0] num_color,
                         input logic [7:0] col,
                         input logic [2:0] row,
                         output logic [2:0] rgb1, rgb2,
                         output logic [3:0] digit);


   logic [12:0] 			    rdaddr_pix;
   logic [3:0] 				    dout_pix_upper, dout_pix_lower;

   logic [9:0] 				    scrollct;
   logic 				    scrollct_done, scrollct_enb;
   
   logic numcol_we;
   logic [31:0] numcol_out;
   logic [9:0] numcol_addr;
   logic pressed; 
   
   assign rdaddr_pix = { (scrollct + col), row };  
  
   assign rgb1 = dout_pix_upper[2:0];
   assign rgb2 = dout_pix_lower[2:0];
   
   assign en_scroll = scrollct_enb && pressed;  

   pixel_ram U_PXRAM(.clk, .rst, .rdaddr_pix_upper(rdaddr_pix), .dout_pix_upper,
                    .rdaddr_pix_lower(rdaddr_pix), .dout_pix_lower,
                    .we_lower(numcol_we), .wraddr_col_lower(numcol_addr), .din_col_lower(numcol_out));
   
   button_switch U_BTN_SWITCH(.clk, .rst, .btn(pause_btn), .pressed); 
   
   delayunit #(.DELAY_MS(85)) U_SCROLLDELAY (.clk, .rst, .done(scrollct_enb));


   scrollctr U_SCTR (.clk, .rst, .scrollct_clr(1'b0), .scrollct_enb(en_scroll), .scrollct, .scrollct_done);
   
   num_writer U_NMWR (.clk, .rst, .nextbtn, .num_color, .numcol_we, .numcol_out, .numcol_addr, .digit);
   


endmodule // pixel_generator
