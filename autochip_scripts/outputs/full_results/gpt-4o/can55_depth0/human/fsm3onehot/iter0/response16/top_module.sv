module top_module (
	input in,
	input [3:0] state,
	output reg [3:0] next_state,
	output reg out
);

	// State transition logic
	always @(*) begin
		case (state)
			4'b0001:    // State A
				if (in)
					next_state = 4'b0010;  // Transition to state B
				else
					next_state = 4'b0001;  // Stay in state A
			4'b0010:    // State B
				if (in)
					next_state = 4'b0010;  // Stay in state B
				else
					next_state = 4'b0100;  // Transition to state C
			4'b0100:    // State C
				if (in)
					next_state = 4'b1000;  // Transition to state D
				else
					next_state = 4'b0001;  // Transition to state A
			4'b1000:    // State D
				if (in)
					next_state = 4'b0010;  // Transition to state B
				else
					next_state = 4'b0100;  // Transition to state C
			default: next_state = 4'b0001; // Default to state A
		endcase
	end

	// Output logic
	always @(*) begin
		case (state)
			4'b1000: out = 1;  // State D
			default: out = 0;  // States A, B, C
		endcase
	end
endmodule
