module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);
	// Define states
	typedef enum logic [1:0] {
		S,
		S1,
		S10
	} state_e;
	
	// Create state and next_state variables
	reg state_e state, next_state;
	
	always @(posedge clk or negedge aresetn) begin
		if (!aresetn) begin
			state <= S; // Initial state
			z <= 0; // Initial value of output z
		end else begin
			state <= next_state; // Update current state
			if (state == S) begin
				case (x)
					0: next_state = S;
					1: next_state = S1;
				endcase
			end else if (state == S1) begin
				case (x)
					0: next_state = S10;
					1: next_state = S1;
				endcase
			end else if (state == S10) begin
				case (x)
					0: next_state = S;
					1: next_state = S1;
				endcase
			end
			// Update output z based on current state
			case (state)
				S, S1: z <= 0;
				S10: z <= x;
			endcase
		end
	end
endmodule
