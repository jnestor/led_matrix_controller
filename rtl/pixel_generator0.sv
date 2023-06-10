module pixel_generator_simple (
    input logic [4:0] col,
    input logic [2:0] row,
    output logic [2:0] rgb1, rgb2
    );

   always_comb
     begin
        // first do the lower half-panel (rgb2)
        if (col == 0) rgb2 = 3'b111;
        else if (col == 2) rgb2 = 3'b100;
        else if (col == 4) rgb2 = 3'b010;
        else if (col == 6) rgb2 = 3'b001;
        else if (col == 10) rgb2 = 3'b110;
        else if (col == 12) rgb2 = 3'b101;
        else if (col == 14) rgb2 = 3'b011;
        else rgb2 = 3'b000;
        // now do the upper half-panel (rgb1)
        if (col >= 16) begin
           case (row)
             3'd0 : rgb1 = 3'b111;
             3'd1 : rgb1 = 3'b100;
             3'd2 : rgb1 = 3'b010;
             3'd3 : rgb1 = 3'b001;
             3'd4 : rgb1 = 3'b000;
             3'd5 : rgb1 = 3'b110;
             3'd6 : rgb1 = 3'b101;
             3'd7 : rgb1 = 3'b011;
             default : rgb1 = 3'b000;
           endcase // case (row)
           end
        else rgb1 = 3'b000;
     end // always_comb

endmodule // pixel_generator
