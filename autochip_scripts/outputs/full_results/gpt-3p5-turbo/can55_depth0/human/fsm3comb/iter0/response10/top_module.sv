module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output reg out
);
	always @* begin
		case (state)
			2'b00: begin // State A
				if (in)
					next_state = 2'b01; // Transition to B on input = 1
				else
					next_state = 2'b00; // Stay in A on input = 0
				out = 1'b0; // Output is always 0 in state A
			end
			
			2'b01: begin // State B
				if (in)
					next_state = 2'b01; // Stay in B on input = 1
				else
					next_state = 2'b10; // Transition to C on input = 0
				out = 1'b0; // Output is always 0 in state B
			end
			
			2'b10: begin // State C
				if (in)
					next_state = 2'b11; // Transition to D on input = 1
				else
					next_state = 2'b00; // Transition to A on input = 0
				out = 1'b0; // Output is always 0 in state C
			end
			
			2'b11: begin // State D
				if (in)
					next_state = 2'b01; // Transition to B on input = 1
				else
					next_state = 2'b10; // Transition to C on input = 0
				out = 1'b1; // Output is always 1 in state D
			end
		endcase
	end
endmodule
