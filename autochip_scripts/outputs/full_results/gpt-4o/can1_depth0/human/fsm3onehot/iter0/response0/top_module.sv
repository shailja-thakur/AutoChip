module top_module (
	input in,
	input [3:0] state,
	output reg [3:0] next_state,
	output out
);

	// Combinational logic for state transitions
	always @(*) begin
		case (state)
			4'b0001: begin // State A
				if (in)
					next_state = 4'b0010; // Move to state B
				else
					next_state = 4'b0001; // Stay in state A
			end
			4'b0010: begin // State B
				if (in)
					next_state = 4'b0010; // Stay in state B
				else
					next_state = 4'b0100; // Move to state C
			end
			4'b0100: begin // State C
				if (in)
					next_state = 4'b1000; // Move to state D
				else
					next_state = 4'b0001; // Move to state A
			end
			4'b1000: begin // State D
				if (in)
					next_state = 4'b0010; // Move to state B
				else
					next_state = 4'b0100; // Move to state C
			end
			default: next_state = 4'b0001; // Default to state A
		endcase
	end

	// Combinational logic for output
	assign out = (state == 4'b1000) ? 1'b1 : 1'b0; // Output is 1 in state D, otherwise 0

endmodule
