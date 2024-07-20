module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output out
);

	always_comb begin
		case (state)
			2'b00: // Current state is A
				if (in)
					next_state = 2'b01; // Transition to B
				else
					next_state = 2'b00; // Remain in A
			2'b01: // Current state is B
				if (in)
					next_state = 2'b01; // Remain in B
				else
					next_state = 2'b10; // Transition to C
			2'b10: // Current state is C
				if (in)
					next_state = 2'b11; // Transition to D
				else
					next_state = 2'b00; // Transition to A
			2'b11: // Current state is D
				if (in)
					next_state = 2'b01; // Transition to B
				else
					next_state = 2'b10; // Transition to C
		endcase
	end

	assign out = (state == 2'b11) ? 1'b1 : 1'b0; // Signal is high when in state D

endmodule
