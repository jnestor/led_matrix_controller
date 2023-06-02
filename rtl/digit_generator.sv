module digit_generator (input logic [3:0] num,
			input logic [2:0]   numcol_index, num_color,
			output logic [31:0] col_out);

   logic [31:0] 			    col_out_white;

   assign col_out = col_out_white & { 8 {{1'b0, num_color}} };
   
   always_comb
      case (num)      // column data L-R = bottom-top
	4'd0: begin
	   case (numcol_index)
	     3'd0 : col_out_white = 32'h0ffffff0;
	     3'd1 : col_out_white = 32'hf000000f;
	     3'd2 : col_out_white = 32'hf000000f;	     
	     3'd3 : col_out_white = 32'hf000000f;
	     3'd4 : col_out_white = 32'h0ffffff0;	     
	     3'd5 : col_out_white = 32'h00000000;
	     default : col_out_white = 32'h10100101; // error in blue!
	   endcase // case (numcol_index)
	end
	4'd1: begin
	   case (numcol_index)
	     3'd0 : col_out_white = 32'h00000000;
	     3'd1 : col_out_white = 32'hf00000f0;
	     3'd2 : col_out_white = 32'hffffffff;	     
	     3'd3 : col_out_white = 32'hf0000000;
	     3'd4 : col_out_white = 32'h00000000;
	     3'd5 : col_out_white = 32'h00000000;
	     default : col_out_white = 32'h10100101; // error in blue!
	   endcase // case (numcol_index)
	end
	4'd2: begin
	   case (numcol_index)
	     3'd0 : col_out_white = 32'hff0000f0;
	     3'd1 : col_out_white = 32'hf0f0000f;
	     3'd2 : col_out_white = 32'hf00f000f;
	     3'd3 : col_out_white = 32'hf000f00f;
	     3'd4 : col_out_white = 32'hf0000ff0;
	     3'd5 : col_out_white = 32'h00000000;
	     default : col_out_white = 32'h10100101; // error in blue!
	   endcase // case (numcol_index)
	end
	4'd3: begin
	   case (numcol_index)
	     3'd0 : col_out_white = 32'h0f0000f0;
	     3'd1 : col_out_white = 32'hf000000f;
	     3'd2 : col_out_white = 32'hf000f00f;	     
	     3'd3 : col_out_white = 32'hf000f00f;
	     3'd4 : col_out_white = 32'h0fff0ff0;
	     3'd5 : col_out_white = 32'h00000000;
	     default : col_out_white = 32'h10100101; // error in blue!
	   endcase // case (numcol_index)
	end
	4'd4: begin
	   case (numcol_index)
	     3'd0 : col_out_white = 32'h0000ffff;
	     3'd1 : col_out_white = 32'h0000f000;
	     3'd2 : col_out_white = 32'h0000f000;	     
	     3'd3 : col_out_white = 32'h0000f000;
	     3'd4 : col_out_white = 32'hffffffff;
	     3'd5 : col_out_white = 32'h00000000;
	     default : col_out_white = 32'h10100101; // error in blue!
	   endcase // case (numcol_index)
	end
	4'd5: begin
	   case (numcol_index)
	     3'd0 : col_out_white = 32'h0f00ffff;
	     3'd1 : col_out_white = 32'hf000f00f;
	     3'd2 : col_out_white = 32'hf000f00f;
	     3'd3 : col_out_white = 32'hf000f00f;
	     3'd4 : col_out_white = 32'h0fff000f;
	     3'd5 : col_out_white = 32'h00000000;
	     default : col_out_white = 32'h10100101; // error in blue!
	   endcase // case (numcol_index)
	end
	4'd6: begin
	   case (numcol_index)
	     3'd0 : col_out_white = 32'h0ffff000;
	     3'd1 : col_out_white = 32'hf000ff00;
	     3'd2 : col_out_white = 32'hf000f0f0;	     
	     3'd3 : col_out_white = 32'hf000f00f;
	     3'd4 : col_out_white = 32'h0fff0000;
	     3'd5 : col_out_white = 32'h00000000;
	     default : col_out_white = 32'h10100101; // error in blue!
	   endcase // case (numcol_index)
	end
	4'd7: begin
	   case (numcol_index)
	     3'd0 : col_out_white = 32'h0000000f;
	     3'd1 : col_out_white = 32'hff00000f;
	     3'd2 : col_out_white = 32'h00ff000f;	     
	     3'd3 : col_out_white = 32'h0000ff0f;
	     3'd4 : col_out_white = 32'h000000ff;
	     3'd5 : col_out_white = 32'h00000000;
	     default : col_out_white = 32'h10100101; // error in blue!
	   endcase // case (numcol_index)
	end
	4'd8: begin
	   case (numcol_index)
	     3'd0 : col_out_white = 32'h0fff0ff0;
	     3'd1 : col_out_white = 32'hf000f00f;
	     3'd2 : col_out_white = 32'hf000f00f;	     
	     3'd3 : col_out_white = 32'hf000f00f;
	     3'd4 : col_out_white = 32'h0fff0ff0;
	     3'd5 : col_out_white = 32'h00000000;
	     default : col_out_white = 32'h10100101; // error in blue!
	   endcase // case (numcol_index)
	end
	4'd9: begin
	   case (numcol_index)
	     3'd0 : col_out_white = 32'h00000ff0;
	     3'd1 : col_out_white = 32'h0000f00f;
	     3'd2 : col_out_white = 32'h0000f00f;	     
	     3'd3 : col_out_white = 32'h0000f00f;
	     3'd4 : col_out_white = 32'hfffffff0;
	     3'd5 : col_out_white = 32'h00000000;
	     default : col_out_white = 32'h10100101; // error in blue!
	   endcase // case (numcol_index)
	end
	default: begin
	   case (numcol_index)      // display an error condition
	     3'd0 : col_out_white = 32'h40404040;
	     3'd1 : col_out_white = 32'hf0202020;
	     3'd2 : col_out_white = 32'h40404040;
	     3'd3 : col_out_white = 32'h02020202;
	     3'd4 : col_out_white = 32'h40404040;
	     3'd5 : col_out_white = 32'h02020202;
	     default : col_out_white = 32'h10100101; // error in blue!
	   endcase // case (numcol_index)
	end
      endcase // case (num)
endmodule // digit_generator
