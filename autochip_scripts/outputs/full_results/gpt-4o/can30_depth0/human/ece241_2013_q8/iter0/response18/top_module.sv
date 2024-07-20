module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// State definitions
	typedef enum logic [1:0] {
		S0, // Initial state
		S1, // State after detecting '1'
		S2  // State after detecting '10'
	} state_t;

	state_t state, next_state;

	// State transition
	always_ff @(posedge clk or negedge aresetn) begin
		if (!aresetn)
			state <= S0;
		else
			state <= next_state;
	end

	// Next state logic and output logic
	always_comb begin
		next_state = state; // Default to hold state
		z = 1'b0; // Default output
		
		case (state)
			S0: begin
				if (x)
					next_state = S1;
			end
			S1: begin
				if (!x)
					next_state = S2;
			end
			S2: begin
				if (x) begin
					next_state = S1;
					z = 1'b1;
				end else
					next_state = S0;
			end
		endcase
	end

endmodule
