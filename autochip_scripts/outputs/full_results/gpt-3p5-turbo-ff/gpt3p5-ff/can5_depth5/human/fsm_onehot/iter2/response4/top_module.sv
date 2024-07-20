module top_module (
	input in,
	input [9:0] state,
	output reg [9:0] next_state,
	output reg out1,
	output reg out2);

	always @* begin
		case(state)
			10'b0000000001: next_state = in ? 10'b0000000010 : 10'b0000000001; // S0
			10'b0000000010: next_state = in ? 10'b0000000011 : 10'b0000000001; // S1
			10'b0000000011: next_state = in ? 10'b0000000100 : 10'b0000000001; // S2
			10'b0000000100: next_state = in ? 10'b0000000101 : 10'b0000000001; // S3
			10'b0000000101: next_state = in ? 10'b0000000110 : 10'b0000000001; // S4
			10'b0000000110: next_state = in ? 10'b0000000111 : 10'b0000001000; // S5
			10'b0000000111: next_state = in ? 10'b0000000101 : 10'b0000001001; // S6
			10'b0000001000: next_state = in ? 10'b0000001000 : 10'b0000000001; // S7
			10'b0000001001: next_state = in ? 10'b0000000010 : 10'b0000000001; // S8
			10'b0000001010: next_state = in ? 10'b0000000010 : 10'b0000000001; // S9
			default: next_state = 10'b0000000000;
		endcase
	end

	always @* begin
		case(state)
			10'b0000000110: out1 = 1'b1;
			default: out1 = 1'b0;
		endcase
		
		case(state)
			10'b0000000111: out2 = 1'b1;
			default: out2 = 1'b0;
		endcase
	end

endmodule
