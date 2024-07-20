module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);

	// State transition logic
	always @* begin
		case(state)
			10'b0000000001: // S0, in=0
				if(in)
					next_state = 10'b0000000010; // S1
				else
					next_state = 10'b0000000001; // S0
			10'b0000000010: // S1, in=0
				if(in)
					next_state = 10'b0000000001; // S0
				else
					next_state = 10'b0000000100; // S2
			10'b0000000100: // S2, in=0
				if (in)
					next_state = 10'b0000000001; // S0
				else
					next_state = 10'b0000001000; // S4
			10'b0000001000: // S4, in=0
				if (in)
					next_state = 10'b0000000001; // S0
				else
					next_state = 10'b0000010000; // S8
			10'b0000010000: // S8, in=0
				if (in)
					next_state = 10'b0000000001; // S0
				else
					next_state = 10'b0000000010; // S1
			10'b0000000010: // S1, in=1
				if (in)
					next_state = 10'b0000000011; // S6
				else
					next_state = 10'b0000000100; // S2
			10'b0000000100: // S2, in=1
				if (in)
					next_state = 10'b0000000101; // S7
				else
					next_state = 10'b0000001000; // S4
			10'b0000001000: // S4, in=1
				if (in)
					next_state = 10'b0000000110; // S5
				else
					next_state = 10'b0000010000; // S8
			10'b0000000110: // S5, in=0
				if (in)
					next_state = 10'b0000010000; // S8
				else
					next_state = 10'b0000100000; // S16
			10'b0000000011: // S6, in=0
				if (in)
					next_state = 10'b0000100000; // S16
				else
					next_state = 10'b0000010010; // S9
			10'b0000010010: // S9, in=0
				if (in)
					next_state = 10'b0000000010; // S1
				else
					next_state = 10'b0000010011; // S10
			10'b0000010011: // S10, in=0
				if (in)
					next_state = 10'b0000000100; // S2
				else
					next_state = 10'b0000010100; // S12
			10'b0000010100: // S12, in=0
				if (in)
					next_state = 10'b0000000011; // S6
				else
					next_state = 10'b0000010101; // S13
			10'b0000010101: // S13, in=0
				if (in)
					next_state = 10'b0000000101; // S7
				else
					next_state = 10'b0000010010; // S9
			default:
				next_state = 10'b0000000000;
		endcase
	end

	// Output logic
	assign out1 = (state[1] && !state[2]) || (state[3] && !state[4]) || (state[5] && !state[6]);
	assign out2 = state[7] && !state[0];
	
endmodule
