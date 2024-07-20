module top_module (
	input in,
	input [9:0] state,
	output reg [9:0] next_state,
	output reg out1,
	output reg out2);

	always @* begin
		case(state)
			10'b0000000001: next_state = (in == 1'b0) ? 10'b0000000001 : 10'b0000000010; // S0
			10'b0000000010: next_state = (in == 1'b0) ? 10'b0000000001 : 10'b0000000011; // S1
			10'b0000000011: next_state = (in == 1'b0) ? 10'b0000000001 : 10'b0000000100; // S2
			10'b0000000100: next_state = (in == 1'b0) ? 10'b0000000001 : 10'b0000000101; // S3
			10'b0000000101: next_state = (in == 1'b0) ? 10'b0000000001 : 10'b0000000110; // S4
			10'b0000000110: next_state = (in == 1'b0) ? 10'b0000001000 : 10'b0000000111; // S5
			10'b0000000111: next_state = (in == 1'b0) ? 10'b0000001001 : 10'b0000000101; // S6
			10'b0000001000: next_state = (in == 1'b0) ? 10'b0000000001 : 10'b0000001000; // S7
			10'b0000001001: next_state = (in == 1'b0) ? 10'b0000000001 : 10'b0000000010; // S8
			10'b0000001010: next_state = (in == 1'b0) ? 10'b0000000001 : 10'b0000000010; // S9
			default: next_state = 10'b0; // Default case to handle undefined state
		endcase
	end
	
	always @* begin
		out1 = (state == 10'b0000000110) ? 1'b1 : 1'b0; // S5 output
		out2 = (state == 10'b0000000111) ? 1'b1 : 1'b0; // S6 output
	end

endmodule
