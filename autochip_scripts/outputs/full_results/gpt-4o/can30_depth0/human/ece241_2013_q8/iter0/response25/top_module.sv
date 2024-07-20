module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// State declaration
	typedef enum logic[1:0] {
		S0, // Initial State
		S1, // State after receiving '1'
		S2  // State after receiving '10'
	} state_t;
	
	// State registers
	state_t current_state, next_state;

	// Sequential block for state transition
	always_ff @(posedge clk or negedge aresetn) begin
		if (!aresetn)
			current_state <= S0;
		else
			current_state <= next_state;
	end

	// Combinational block for next state logic
	always_comb begin
		// Default assignments
		next_state = current_state;
		z = 1'b0;
		
		// State transition logic
		case (current_state)
			S0: begin
				if (x)
					next_state = S1;
			end
			S1: begin
				if (!x)
					next_state = S2;
				else
					next_state = S1; // Stay in S1 if we get another '1'
			end
			S2: begin
				if (x) begin
					next_state = S1;
					z = 1'b1; // Output '1' when sequence "101" is detected
				end else 
					next_state = S0;
			end
		endcase
	end

endmodule
