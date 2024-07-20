module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output reg out
);

	always_comb begin
		case (state)
			2'b00: begin // State A
				if (in)
					next_state = 2'b01; // Transition to state B
				else
					next_state = 2'b00; // Remain in state A
					
				out = 0; // Set output to low
			end
			
			2'b01: begin // State B
				if (in)
					next_state = 2'b01; // Remain in state B
				else
					next_state = 2'b10; // Transition to state C
					
				out = 0; // Set output to low
			end
			
			2'b10: begin // State C
				if (in)
					next_state = 2'b11; // Transition to state D
				else
					next_state = 2'b00; // Transition to state A
					
				out = 0; // Set output to low
			end
			
			2'b11: begin // State D
				if (in)
					next_state = 2'b01; // Transition to state B
				else
					next_state = 2'b10; // Transition to state C
					
				out = 1; // Set output to high
			end
			
			default: begin // Default case
				next_state = 2'b00; // Default next state is A
				out = 0; // Set output to low
			end
		endcase
	end

endmodule
