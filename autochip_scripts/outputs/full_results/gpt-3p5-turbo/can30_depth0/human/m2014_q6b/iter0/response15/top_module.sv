module top_module(
	input [3:1] y,
	input w,
	output reg Y2);

	always @ (y[3:1], w)
	begin
		case ({y[3:1], w})
			3'b0000: Y2 = 1'b0; // State A, input 0
			3'b0001: Y2 = 1'b1; // State A, input 1
			3'b0010: Y2 = 1'b0; // State B, input 0
			3'b0011: Y2 = 1'b1; // State B, input 1
			3'b0100: Y2 = 1'b1; // State C, input 0
			3'b0101: Y2 = 1'b1; // State C, input 1
			3'b0110: Y2 = 1'b0; // State D, input 0
			3'b0111: Y2 = 1'b1; // State D, input 1
			3'b1000: Y2 = 1'b1; // State E, input 0
			3'b1001: Y2 = 1'b1; // State E, input 1
			3'b1010: Y2 = 1'b0; // State F, input 0
			3'b1011: Y2 = 1'b1; // State F, input 1
			default: Y2 = 1'b0; // Default output
		endcase
	end
	
endmodule
