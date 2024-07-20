module top_module (
	input in,
	input [3:0] state,
	output reg [3:0] next_state,
	output out
);

	// Output logic
	assign out = state[3]; // D is 4'b1000, so state[3] will be '1' only when state is D, making the output '1'
	
	// State transition logic
	always @(*) begin
		case (state)
			4'b0001: // state A
				next_state = (in) ? 4'b0010 : 4'b0001; // if in == 1, move to B else stay in A
			4'b0010: // state B
				next_state = (in) ? 4'b0010 : 4'b0100; // if in == 1, stay in B else move to C
			4'b0100: // state C
				next_state = (in) ? 4'b1000 : 4'b0001; // if in == 1, move to D else move to A
			4'b1000: // state D
				next_state = (in) ? 4'b0010 : 4'b0100; // if in == 1, move to B else move to C
			default: // Undefined state -- transition to safe state A
				next_state = 4'b0001;
		endcase
	end

endmodule
