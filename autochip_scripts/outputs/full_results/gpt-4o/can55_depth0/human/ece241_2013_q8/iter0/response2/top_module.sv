module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// State encoding
	typedef enum reg [1:0] {
		S0, // Initial state
		S1, // State after seeing '1'
		S2  // State after seeing '10'
	} state_t;

	state_t state, next_state;

	// State transition (Mealy type)
	always @(posedge clk or negedge aresetn) begin
		if (!aresetn)
			state <= S0;
		else
			state <= next_state;
	end

	// Next state logic
	always @(*) begin
		next_state = state; // Default to hold state
		z = 0; // Default to 0

		case (state)
			S0: begin
				if (x)
					next_state = S1;
			end
			S1: begin
				if (!x)
					next_state = S2;
				else
					next_state = S1;
			end
			S2: begin
				if (x) begin
					next_state = S1;
					z = 1; // Sequence 101 detected
				end else
					next_state = S0;
			end
		endcase
	end

endmodule
