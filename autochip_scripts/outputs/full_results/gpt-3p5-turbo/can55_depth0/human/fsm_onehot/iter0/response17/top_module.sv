module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);

	reg [9:0] next_state;
	reg out1;
	reg out2;

	always @(*) begin
		// State transition logic
		case (state)
			10'b0000000001: next_state = 10'b0000000001; // S0 -> S0
			10'b0000000010: next_state = 10'b0000000100; // S1 -> S4
			10'b0000000100: next_state = 10'b0000000001; // S4 -> S0
			10'b0000001000: next_state = 10'b0000000010; // S8 -> S1
			10'b0000010000: next_state = 10'b0000000001; // S9 -> S0
			default: next_state = 10'b0000000001; // Default case
		endcase

		// Output logic
		case (state)
			10'b0000000111: begin
				out1 = 1'b0;
				out2 = 1'b1;
			end
			default: begin
				out1 = 1'b0;
				out2 = 1'b0;
			end
		endcase
	end

endmodule
