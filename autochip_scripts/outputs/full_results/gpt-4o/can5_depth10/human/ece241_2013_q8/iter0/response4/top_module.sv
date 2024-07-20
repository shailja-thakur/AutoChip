module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// State encoding
	typedef enum logic [1:0] {
		S0 = 2'b00, // Initial state
		S1 = 2'b01, // Got '1'
		S2 = 2'b10  // Got '10'
	} state_t;

	state_t state, next_state;

	// Sequential part: State transition
	always_ff @(negedge aresetn or posedge clk) begin
		if (!aresetn)
			state <= S0; // Asynchronous reset
		else
			state <= next_state;
	end
	
	// Combinational part: State transition logic
	always_comb begin
		next_state = state; // Default to no state change
		z = 0; // Default output

		case (state)
			S0: begin
				if (x) next_state = S1;
			end

			S1: begin
				if (!x) next_state = S2;
				else next_state = S1;
			end

			S2: begin
				if (x) next_state = S1;
				else next_state = S0;
			end

			default: next_state = S0;
		endcase

		// Output logic
		if (state == S2 && x)
			z = 1;
	end

endmodule
