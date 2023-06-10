module sequencer_fsm (
    input logic clk, rst, half_enb, colct_eq_max,
    output logic sclk_r_clr, sclk_r_set, rowct_clr,
    output logic rowct_enb, colct_clr, colct_enb, blank, lat
    );
    
parameter NUM_PANELS = 1;

enum logic [2:0] { BLANK2, SCLK_LO, SCLK_HI, BLANK0, BLANK1, LATCH } state, next;

always_ff @(posedge clk)
  if (rst) state <= BLANK2;
  else state <= next;

always_comb
  begin
     sclk_r_clr = 0;
     sclk_r_set = 0;
     rowct_clr = 0;
     rowct_enb = 0;
     colct_clr = 0;
     colct_enb = 0;
     blank = 0;
     lat = 0;
     next = BLANK2;
     case (state)
       SCLK_LO :
          begin
             sclk_r_clr = 1;
             if (half_enb) next = SCLK_HI;
             else next = SCLK_LO;
          end
       SCLK_HI :
          begin
             sclk_r_set = 1;
             if (half_enb)
               begin
                  if (colct_eq_max) next = BLANK0;
                  else
                    begin
                       colct_enb = 1;
                       next = SCLK_LO;
                    end
               end
             else next = SCLK_HI;
          end
       BLANK0 :
          begin
              sclk_r_clr = 1;
              colct_clr = 1;
              if (half_enb) 
                begin
                  rowct_enb = 1;
                  next = BLANK1;
                end
              else next = BLANK0;
          end
       BLANK1 :
          begin
             blank = 1;
             sclk_r_clr = 1;
             colct_clr = 1;
             if (half_enb) next = LATCH;
             else next = BLANK1;
          end
       LATCH :
         begin
            blank = 1;
            lat = 1;
            if (half_enb) next = BLANK2;
            else next = LATCH;
         end
       BLANK2 :
         begin
            blank = 1;
            if (half_enb) next = SCLK_LO;
            else next = BLANK2;
         end 
       default : next = BLANK2;
     endcase
  end

endmodule // sequencer_fsm
