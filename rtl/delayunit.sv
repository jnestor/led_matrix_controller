//-----------------------------------------------------------------------------
// Title         : delayunit - parameterized delay unit
// Project       : ECE 212 - Digital Circuits II
//-----------------------------------------------------------------------------
// File          : clkenb.sv
// Author        : John Nestor
// Created       : 01.06.2019
// Last modified : 01.06.2019
//-----------------------------------------------------------------------------
// Description :
// This module generates a delay by counting clock ticks until the desired
// limit is reached.  It should be instantiated with a delay value given in
// either milliseconds, microseconds, or nanoseconds.  When reset it will
// count until the delay value is reached at which point it will assert
// the done output for exactly one clock period.  It will then wait forr
// another delay period before asserting done again.
//-----------------------------------------------------------------------------

module delayunit(input logic clk, rst, output logic done);

   parameter DELAY_MS = 1;
   parameter DELAY_US = DELAY_MS * 1000;
   parameter DELAY_NS = DELAY_US * 1000;
   parameter CLKPD_NS = 10;  // default matches 100MHz clk freq of Nexys4

   parameter DELAY_COUNT_LIMIT = DELAY_NS / CLKPD_NS;
   parameter DELAY_COUNT_BITS = $clog2(DELAY_COUNT_LIMIT);
   
   logic [DELAY_COUNT_BITS-1:0] q;

   assign done = (q == DELAY_COUNT_LIMIT -1);
   
   always_ff @(posedge clk)
     if (rst) q <= 0;
     else if (q == DELAY_COUNT_LIMIT-1) q <= 0;
     else q <=  q + 1;
   
endmodule // delayunit




   
  
