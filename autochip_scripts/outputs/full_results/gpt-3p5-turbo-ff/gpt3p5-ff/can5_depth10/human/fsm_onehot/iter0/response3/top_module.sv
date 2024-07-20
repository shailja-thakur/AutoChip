module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);

	assign out1 = (state[7] & in) | (state[8] & ~in) | (state[9] & in);
	assign out2 = state[5] | (state[6] & ~in);

	always @* begin
		case (1'b1)
			state[0]: next_state = 10'b0000000001;
			state[1]: next_state = 10'b0000000010;
			state[2]: next_state = 10'b0000000100;
			state[3]: next_state = 10'b0000001000;
			state[4]: next_state = 10'b0000010000;
			state[5]: next_state = 10'b0000100000;
			state[6]: next_state = 10'b0001000000;
			state[7]: next_state = 10'b0010000001;
			state[8]: next_state = 10'b0100000010;
			state[9]: next_state = 10'b1000000100;
			default: next_state = 10'b0000000000;
		endcase
	end

endmodule
