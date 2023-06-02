`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2022 10:09:23 PM
// Design Name: 
// Module Name: top_level
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


module single_pulse_btn(input logic clk, rst,
                 input logic btn,
                 output logic pressed
                 );

   typedef enum logic [1:0]{
        NO_PRESS, MAYBE_PRESS, PRESS, HELD
   }states_t; 


   states_t cur_state, next_state; 

   always_ff @(posedge clk) begin
        if(rst) cur_state <= NO_PRESS; 
        else cur_state <= next_state; 
   end

   //Next state and output logic 

   always_comb begin
       
        //Next state logic 
        case(cur_state)

            NO_PRESS: begin
                if(btn) next_state = MAYBE_PRESS; 
                else next_state = NO_PRESS; 
            end

            MAYBE_PRESS: begin
                if(btn) next_state = PRESS; 
                else next_state = NO_PRESS; 
            end

            PRESS: begin
                next_state = HELD; 
            end

            HELD: begin
                if(btn) next_state = HELD; 
                else next_state = NO_PRESS; 
            end

        endcase

        //output logic 
        case(cur_state)

            NO_PRESS: begin
                pressed = 0; 
            end

            MAYBE_PRESS: begin
                pressed = 0; 
            end

            PRESS: begin
                pressed = 1; 
            end

            HELD: begin
                pressed = 0; 
            end

        endcase
   end

endmodule
