module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output out
);

	always_comb begin
		case (state)
			2'b00: begin // State A
				if (in) next_state = 2'b01; // Transition to State B if in is high
				else next_state = 2'b00; // Stay in State A if in is low
			end
			2'b01: begin // State B
				if (in) next_state = 2'b01; // Stay in State B if in is high
				else next_state = 2'b10; // Transition to State C if in is low
			end
			2'b10: begin // State C
				if (in) next_state = 2'b11; // Transition to State D if in is high
				else next_state = 2'b00; // Transition to State A if in is low
			end
			2'b11: begin // State D
				if (in) next_state = 2'b01; // Transition to State B if in is high
				else next_state = 2'b10; // Transition to State C if in is low
			end
		endcase

		// Assign out signal based on current state
		if (state == 2'b11) out = 1'b1; // Set out to high if in State D
		else out = 1'b0; // Set out to low otherwise
	end

endmodule
