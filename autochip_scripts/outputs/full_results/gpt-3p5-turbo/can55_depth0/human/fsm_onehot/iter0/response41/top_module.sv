module top_module (
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);

	// Output Declarations
	assign out1 = (state[7] & !in) | (state[8] & state[9] & !in);
	assign out2 = state[7] & state[9];
	
	// Next State Logic
	always @* begin
		case(state)
			10'b0000000001: next_state = 10'b0000000001;
			10'b0000000010: next_state = 10'b0000000100;
			10'b0000000100: next_state = 10'b0000000001;
			10'b0000001000: next_state = 10'b0000001000;
			10'b0000010000: next_state = 10'b0000000001;
			10'b0000100000: next_state = 10'b0000001000;
			10'b0001000000: next_state = 10'b0000000001;
			10'b0010000000: next_state = 10'b0000010000;
			10'b0100000000: next_state = 10'b0000000001;
			10'b1000000000: next_state = 10'b0000000010;
		endcase
	end

endmodule
