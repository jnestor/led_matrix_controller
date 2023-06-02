`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2022 10:47:18 AM
// Design Name: 
// Module Name: button_switch
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module button_switch(input logic clk, rst, btn,
                     output logic pressed);
                     
    logic pulse; 
    
    single_pulse_btn U_PULSE(.clk, .rst, .btn, .pressed(pulse)); 

    always_ff @(posedge clk) begin
        if(rst) pressed <= 1'b0; 
        else if(pulse) pressed <= ~pressed; 
    end

endmodule
